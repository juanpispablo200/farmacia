import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';

Widget menuAdminOld(BuildContext context) {
  GlobalKey btnKey = GlobalKey();

  return Padding(
    padding: const EdgeInsets.only(right: 15.0), // Adjust the value as needed
    child: GestureDetector(
      key: btnKey,
      child: const Icon(Icons.menu),
      onTap: () {
        PopupMenu menu = PopupMenu(
          config: const MenuConfig(
            backgroundColor: Colors.white,
            highlightColor: Colors.black,
            lineColor: Colors.black,
            itemWidth: 75,
          ),
          items: [
            MenuItem(
              title: 'Categorías',
              textStyle: const TextStyle(color: Colors.black),
              image: const Icon(Icons.category),
            ),
            MenuItem(
              title: 'Productos',
              textStyle: const TextStyle(color: Colors.black),
              image: const Icon(Icons.list),
            ),
            MenuItem(
              title: 'Perfil',
              textStyle: const TextStyle(color: Colors.black),
              image: const Icon(Icons.person),
            )
          ],
          onClickMenu: (MenuItemProvider item) {
            switch (item.menuTitle) {
              case 'Categorías':
                Navigator.pushNamed(context, 'lista_categorias');
                break;
              case 'Productos':
                Navigator.pushNamed(context, 'lista_productos');
                break;
              case 'Perfil':
                Navigator.pushNamed(context, 'perfil');
                break;
            }
          },
          context: context,
        );
        menu.show(widgetKey: btnKey);
      },
    ),
  );
}

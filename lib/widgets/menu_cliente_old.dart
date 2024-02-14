import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';

Widget menuClienteOld(BuildContext context) {
  GlobalKey btnKey = GlobalKey();

  return Padding(
    padding: const EdgeInsets.only(right: 15.0),
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
              title: 'Carrito',
              textStyle: const TextStyle(color: Colors.black),
              image: const Icon(Icons.shopping_cart),
            ),
            MenuItem(
              title: 'Perfil',
              textStyle: const TextStyle(color: Colors.black),
              image: const Icon(Icons.person),
            ),
            MenuItem(
              title: 'Config',
              textStyle: const TextStyle(color: Colors.black),
              image: const Icon(Icons.settings),
            ),
            MenuItem(
              title: 'ChatBot',
              textStyle: const TextStyle(color: Colors.black),
              image: const Icon(Icons.chat),
            ),
          ],
          onClickMenu: (MenuItemProvider item) {
            switch (item.menuTitle) {
              case 'Categorías':
                Navigator.pushNamed(context, 'lista_categorias_cli');
                break;
              case 'Productos':
                Navigator.pushNamed(context, 'lista_productos_cli');
                break;
              case 'Carrito':
                Navigator.pushNamed(context, 'carrito');
                break;
              case 'Perfil':
                Navigator.pushNamed(context, 'perfil');
                break;
              case 'Config':
                Navigator.pushNamed(context, 'config');
                break;
              case 'ChatBot':
                Navigator.pushNamed(context, 'chatbot_cli');
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

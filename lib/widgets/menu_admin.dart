import 'package:flutter/material.dart';

///import 'package:farmacia/pages/productos/lista_productos.dart';

Widget menuAdmin(BuildContext context, Color color) {
  return Column(
    children: <Widget>[
      Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: MenuBar(
              children: <Widget>[
                SubmenuButton(
                  menuChildren: <Widget>[
                    MenuItemButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'lista_categorias');
                      },
                      child: const MenuAcceleratorLabel('Categorías Admin'),
                    ),
                    MenuItemButton(
                      onPressed: () {
                        //Navigator.push(context, 'lista_productos');
                        Navigator.pushNamed(context, 'lista_productos');
                      },
                      child: const MenuAcceleratorLabel('Productos Admin'),
                    ),
                  ],
                  child: const MenuAcceleratorLabel('Productos Admin'),
                ),
                SubmenuButton(
                  menuChildren: <Widget>[
                    MenuItemButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'carrito');
                      },
                      child: const MenuAcceleratorLabel('Ver Detalles'),
                    ),
                  ],
                  child: const MenuAcceleratorLabel('Carrito Admin'),
                ),
              ],
            ),
          ),
        ],
      ),
      Expanded(
          child: Opacity(
              opacity: 0.5, child: Image.asset('assets/img/LogoUide.png')))
    ],
  );
}

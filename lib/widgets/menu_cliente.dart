import 'package:flutter/material.dart';
//import 'package:farmacia/pages/productos/lista_productos.dart';

Widget menuCliente(BuildContext context, Color color) {
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
                        Navigator.pushNamed(context, 'lista_categorias_cli');
                      },
                      child: const MenuAcceleratorLabel('Categorías'),
                    ),
                    MenuItemButton(
                      onPressed: () {
                        //Navigator.push(context, 'lista_productos');
                        Navigator.pushNamed(context, 'lista_productos_cli');
                      },
                      child: const MenuAcceleratorLabel('Productos'),
                    ),
                  ],
                  child: const MenuAcceleratorLabel('Productos'),
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
                  child: const MenuAcceleratorLabel('Carrito'),
                ),
              ],
            ),
          ),
        ],
      ),
      Expanded(
          child: Opacity(
              opacity: 0.5, child: Image.asset('assets/img/LogoUide.png'))),
    ],
  );
}

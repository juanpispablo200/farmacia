import 'package:flutter/material.dart';
//import 'package:restaurante/pages/productos/lista_productos.dart';

Widget menuCliente( BuildContext context, Color color){
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Listado de categorías!'),
                          ),
                        );
                      },
                      child: const MenuAcceleratorLabel('Categorías'),
                    ),
                    MenuItemButton(
                      onPressed: () {
                        //Navigator.push(context, 'lista_productos');
                        Navigator.pushNamed(context, 'lista_productos_cli');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Listado de Productos!'),
                          ),
                        );
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Detalle Carrito!'),
                          ),
                        );
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
        child: Image.asset('assets/img/LogoUide.png'),
      ),
    ],

  );
}

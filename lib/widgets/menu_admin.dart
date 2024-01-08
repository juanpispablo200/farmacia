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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Listado de categorías!'),
                          ),
                        );
                      },
                      child: const MenuAcceleratorLabel('Categorías Admin'),
                    ),
                    MenuItemButton(
                      onPressed: () {
                        //Navigator.push(context, 'lista_productos');
                        Navigator.pushNamed(context, 'lista_productos');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Listado de Productos!'),
                          ),
                        );
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Detalle Carrito!'),
                          ),
                        );
                      },
                      child: const MenuAcceleratorLabel('Ver Detalles'),
                    ),
                  ],
                  child: const MenuAcceleratorLabel('Carrito Admin'),
                ),
                MenuItemButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'lista_usuarios');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Lista de usuarios!'),
                      ),
                    );
                  },
                  child: const MenuAcceleratorLabel('UsuariosAdmin'),
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

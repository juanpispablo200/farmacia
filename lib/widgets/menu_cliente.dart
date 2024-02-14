import 'package:flutter/material.dart';

Widget menuCliente(BuildContext context) {
  return PopupMenuButton<String>(
    icon: const Icon(Icons.menu),
    onSelected: (String result) {
      switch (result) {
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
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        child: SizedBox(
          height: 170,
          width: 250,
          child: GridView.count(
            crossAxisCount: 3,
            children: <Widget>[
              _buildMenuItem(context, 'Categorías', Icons.category),
              _buildMenuItem(context, 'Productos', Icons.list),
              _buildMenuItem(context, 'Carrito', Icons.shopping_cart),
              _buildMenuItem(context, 'Perfil', Icons.person),
              _buildMenuItem(context, 'Config', Icons.settings),
              _buildMenuItem(context, 'ChatBot', Icons.chat),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildMenuItem(BuildContext context, String title, IconData icon) {
  return InkWell(
    onTap: () {
      Navigator.pop(context, title);
    },
    onHover: (value) {},
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, size: 30.0),
        Text(title),
      ],
    ),
  );
}

import 'package:flutter/material.dart';

Widget menuAdmin(BuildContext context) {
  return PopupMenuButton<String>(
    icon: const Icon(Icons.menu),
    onSelected: (String result) {
      switch (result) {
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
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        child: SizedBox(
          height: 90,
          width: 250,
          child: GridView.count(
            crossAxisCount: 3,
            children: <Widget>[
              _buildMenuItem(context, 'Categorías', Icons.category),
              _buildMenuItem(context, 'Productos', Icons.list),
              _buildMenuItem(context, 'Perfil', Icons.person),
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

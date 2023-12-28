import 'package:flutter/material.dart';

import 'package:farmacia/modelos/productos.dart';

class FichaProductoCar extends StatelessWidget {
  final Producto producto;

  FichaProductoCar({
    required this.producto,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      color: Colors.amberAccent,
      child: ListTile(
        leading: Text(
          '${producto.nombre}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        title: Text(producto.precio),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //GestureDetector(
            //child: Icon(Icons.edit),
            //onTap: onTapAdd,
            //),
          ],
        ),
      ),
    );
  }
}

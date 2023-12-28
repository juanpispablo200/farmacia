import 'package:flutter/material.dart';

import 'package:farmacia/modelos/productos.dart';

class FichaProductoCli extends StatelessWidget {
  final Producto producto;
  final VoidCallback onTapAdd;

  FichaProductoCli({
    required this.producto,
    required this.onTapAdd,
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
        title: Text(producto.categoria),
        subtitle: Text(producto.descripcion),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //GestureDetector(
            //child: Icon(Icons.edit),
            //onTap: onTapAdd,
            //),
            GestureDetector(
              child: Icon(Icons.plus_one_sharp),
              onTap: onTapAdd,
            )
          ],
        ),
      ),
    );
  }
}

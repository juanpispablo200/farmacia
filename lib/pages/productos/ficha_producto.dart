import 'package:flutter/material.dart';

import 'package:farmacia/modelos/productos.dart';

class FichaProducto extends StatelessWidget {
  final Producto producto;
  final VoidCallback onTapEdit, onTapDelete;

  const FichaProducto({
    super.key,
    required this.producto,
    required this.onTapEdit,
    required this.onTapDelete,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      color: Colors.amberAccent,
      child: ListTile(
        leading: Text(
          producto.nombre,
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
              onTap: onTapEdit,
              child: const Icon(Icons.edit),
            ),
            GestureDetector(
              onTap: onTapDelete,
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}

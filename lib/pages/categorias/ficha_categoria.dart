import 'package:flutter/material.dart';

import 'package:farmacia/modelos/categorias.dart';

class FichaCategoria extends StatelessWidget {
  final Categoria categoria;
  final VoidCallback onTapEdit, onTapDelete;

  const FichaCategoria(
      {super.key,
      required this.categoria,
      required this.onTapDelete,
      required this.onTapEdit});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      color: Colors.lightBlueAccent,
      child: ListTile(
        leading: Text(
          categoria.nombre,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        title: Text(categoria.descripcion),
        //subtitle: Text(categoria.),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: onTapEdit,
              child: const Icon(Icons.edit),
            ),
            GestureDetector(
              onTap: onTapDelete,
              child: const Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }
}

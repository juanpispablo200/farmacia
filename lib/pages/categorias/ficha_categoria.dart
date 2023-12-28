///import 'package:/modelos/categorias.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FichaCategoria extends StatelessWidget {

  final Categoria categoria;
  final VoidCallback onTapEdit, onTapDelete;

  FichaCategoria ({
    required this.categoria,
    required this.onTapDelete,
    required this.onTapEdit
  }
      );
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      color: Colors.amberAccent,
      child: ListTile(
        leading: Text('${categoria.nombre}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        title: Text(categoria.descripcion),
        //subtitle: Text(categoria.),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              child: Icon(Icons.edit),
              onTap: onTapEdit,
            ),
            GestureDetector(
              child: Icon(Icons.delete),
              onTap: onTapDelete,
            )
          ],
        ),
      ),
    );
  }
}
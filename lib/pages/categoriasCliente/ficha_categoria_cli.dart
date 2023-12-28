import 'package:flutter/material.dart';

import 'package:farmacia/modelos/categorias.dart';

class FichaCategoriaCli extends StatelessWidget {
  final Categoria categoria;
  final VoidCallback onTapAdd;

  const FichaCategoriaCli({required this.categoria, required this.onTapAdd});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      color: Colors.amberAccent,
      child: ListTile(
        leading: Text(
          '${categoria.nombre}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        title: Text(categoria.descripcion),
        //subtitle: Text(categoria.),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: onTapAdd,
              child: const Icon(Icons.plus_one_sharp),
            )
          ],
        ),
      ),
    );
  }
}

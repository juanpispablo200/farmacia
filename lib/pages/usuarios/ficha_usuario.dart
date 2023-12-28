import 'package:farmacia/modelos/usuarios.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FichaUsuario extends StatelessWidget {
  final Usuario usuario;
  final VoidCallback onTapEdit, onTapDelete;

  FichaUsuario(
      {required this.usuario,
      required this.onTapDelete,
      required this.onTapEdit});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      color: Colors.amberAccent,
      child: ListTile(
        leading: Text(
          '${usuario.correo}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        title: Text(usuario.nombres),
        subtitle: Text(usuario.apellidos),
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

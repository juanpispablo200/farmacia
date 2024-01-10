import 'package:farmacia/modelos/usuarios.dart';
import 'package:flutter/material.dart';

class FichaUsuario extends StatelessWidget {
  final Usuario usuario;
  final VoidCallback onTapEdit, onTapDelete;

  const FichaUsuario(
      {super.key,
      required this.usuario,
      required this.onTapDelete,
      required this.onTapEdit});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      color: Colors.lightBlue,
      child: ListTile(
        leading: SizedBox(
          width: 125, // Adjust this value as needed
          child: Text(
            usuario.correo,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        title: Row(
          children: [
            SizedBox(
              width: 125, // Adjust this value as needed
              child: Text(usuario.nombres),
            ),
            const SizedBox(width: 8.0), // Add some space between the names
            SizedBox(
              width: 120, // Adjust this value as needed
              child: Text(usuario.apellidos),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: onTapEdit,
                child: const Icon(Icons.edit),
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: onTapDelete,
                child: const Icon(Icons.delete),
              ),
            )
          ],
        ),
      ),
    );
  }
}

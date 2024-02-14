import 'package:flutter/material.dart';

import 'package:farmacia/modelos/usuarios.dart';

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
    return Card(
      elevation: 2.0,
      color: const Color.fromARGB(174, 64, 195, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: _buildLeading(context),
          title: _buildBody(context),
          trailing: _buildTrailing(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${usuario.nombres} ${usuario.apellidos}',
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          usuario.correo,
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 4.0),
        Text(
          usuario.telefono,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget _buildLeading(BuildContext context) {
    return Image.asset(
      'assets/img/avatar.png',
      width: 200,
      height: 200,
      fit: BoxFit.fitHeight,
    );
  }

  Widget _buildTrailing(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: onTapEdit,
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onTapDelete,
        ),
      ],
    );
  }
}

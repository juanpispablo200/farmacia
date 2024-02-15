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
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Material(
        elevation: 2.0,
        color: const Color.fromARGB(174, 64, 195, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: _buildLeading(context),
              ),
              Expanded(
                flex: 1,
                child: _buildTrailing(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeading(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: ListView(
        shrinkWrap: true,
        children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
              children: <TextSpan>[
                const TextSpan(
                  text: 'Nombre: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: categoria.nombre),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
              children: <TextSpan>[
                const TextSpan(
                  text: 'Descripcion: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: categoria.descripcion),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrailing() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
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
    );
  }
}

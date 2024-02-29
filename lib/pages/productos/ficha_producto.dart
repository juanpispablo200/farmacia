import 'package:flutter/material.dart';

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/productos.dart';
import 'package:farmacia/modelos/categorias.dart';
import 'package:farmacia/widgets/loading_screen.dart';

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
      color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: _buildLeading(),
          trailing: _buildTrailing(),
        ),
      ),
    );
  }

  Widget _buildLeading() {
    return FutureBuilder<Categoria?>(
      future: obtenerCategoria(producto),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          if (snapshot.data != null) {
            Categoria categoria = snapshot.data!;
            return RichText(
              text: TextSpan(
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
                children: <TextSpan>[
                  const TextSpan(
                      text: 'Nombre: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${producto.nombre} | '),
                  const TextSpan(
                      text: 'Precio: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${producto.precio}\$ | '),
                  const TextSpan(
                      text: 'Stock: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${producto.stock} | '),
                  const TextSpan(
                      text: 'Categoria: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${categoria.nombre} |'),
                ],
              ),
            );
          } else {
            return const Text('Incorrect data');
          }
        }
      },
    );
  }

  Widget _buildTrailing() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: onTapEdit,
          child: const Icon(Icons.edit),
        ),
        GestureDetector(
          onTap: onTapDelete,
          child: const Icon(Icons.delete),
        ),
      ],
    );
  }

  Future<Categoria?> obtenerCategoria(Producto producto) async {
    var categoria = MongoDB.getCategoriaPorId(producto.categoria);
    return categoria;
  }
}

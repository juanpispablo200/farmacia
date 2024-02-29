import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:farmacia/modelos/categorias.dart';

import 'package:farmacia/modelos/productos.dart';

class FichaProductoCli extends StatefulWidget {
  final Producto producto;
  final Future<void> Function() onTapAdd;

  const FichaProductoCli({
    super.key,
    required this.producto,
    required this.onTapAdd,
  });

  @override
  FichaProductoCliState createState() => FichaProductoCliState();
}

class FichaProductoCliState extends State<FichaProductoCli> {
  Producto get producto => widget.producto;
  VoidCallback get onTapAdd => widget.onTapAdd;

  bool _isLoading = false;

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
        child: InkWell(
          onTap: _onTap,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: _buildLeading(),
              ),
              _buildTrailing(),
            ],
          ),
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
    return IconButton(
      onPressed: _isLoading
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await widget.onTapAdd();
              setState(() {
                _isLoading = false;
              });
            },
      icon: _isLoading
          ? const SizedBox(
              height: 20.0,
              width: 20.0,
              child: CircularProgressIndicator.adaptive(strokeWidth: 2.0),
            )
          : const Icon(Icons.add),
    );
  }

  void _onTap() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.producto.nombre),
          content: Text(widget.producto.descripcion),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Categoria?> obtenerCategoria(Producto producto) async {
    var categoria = MongoDB.getCategoriaPorId(producto.categoria);
    return categoria;
  }
}

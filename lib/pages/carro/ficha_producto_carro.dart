import 'package:flutter/material.dart';

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/productos.dart';

class FichaProductoCar extends StatefulWidget {
  final String productoId;
  final String userId;

  const FichaProductoCar(
      {required this.productoId, required this.userId, Key? key})
      : super(key: key);

  @override
  FichaProductoCarState createState() => FichaProductoCarState();
}

class FichaProductoCarState extends State<FichaProductoCar> {
  String get productoId => widget.productoId;
  String get userId => widget.userId;

  late Future<Producto?> _productoFuture;

  @override
  void initState() {
    super.initState();
    _productoFuture = MongoDB.getProductoPorId(productoId);
  }

  void _removeProductoCarro(String usuarioId, Producto producto) {
    MongoDB.removerProdCr(usuarioId, producto);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Producto?>(
      future: _productoFuture,
      builder: (BuildContext context, AsyncSnapshot<Producto?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          Producto? producto = snapshot.data;
          return Material(
            elevation: 2.0,
            color: Colors.lightBlueAccent,
            child: ListTile(
              leading: Text(
                producto!.nombre,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              title: Text("${producto.precio} \$"),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _removeProductoCarro(userId, producto);
                },
              ),
            ),
          );
        }
        return const Text("No hay datos");
      },
    );
  }
}

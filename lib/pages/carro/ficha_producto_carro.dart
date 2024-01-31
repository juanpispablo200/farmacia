import 'package:flutter/material.dart';

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/productos.dart';

class FichaProductoCar extends StatefulWidget {
  final String userId;
  final String productoId;
  final Future<void> Function() onTapDelete;
  final Future<Map<String, dynamic>?> carro;

  const FichaProductoCar({
    super.key,
    required this.carro,
    required this.userId,
    required this.productoId,
    required this.onTapDelete,
  });

  @override
  FichaProductoCarState createState() => FichaProductoCarState();
}

class FichaProductoCarState extends State<FichaProductoCar> {
  late final Future<Producto?> _productoFuture;

  bool _isLoading = false;
  int _currentQuantity = 1;

  @override
  void initState() {
    super.initState();
    _productoFuture = MongoDB.getProductoPorId(widget.productoId);
    widget.carro.then((value) {
      if (value != null) {
        setState(() {
          _currentQuantity = value['productos'][widget.productoId];
        });
      }
    });
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
          final producto = snapshot.data;
          return Material(
              elevation: 2.0,
              color: Colors.lightBlueAccent,
              child: ListTile(
                leading: Text(
                  producto!.nombre,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                title: Row(
                  children: [
                    Text("${producto.precio}\$"),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () async {
                        if (_currentQuantity > 0) {
                          _currentQuantity--;
                          await MongoDB.actualizarCantidadCr(
                            widget.userId,
                            widget.productoId,
                            _currentQuantity,
                          );
                          setState(() {});
                        }
                      },
                    ),
                    Text(_currentQuantity.toString()),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () async {
                        _currentQuantity++;
                        await MongoDB.actualizarCantidadCr(
                          widget.userId,
                          widget.productoId,
                          _currentQuantity,
                        );
                        setState(() {});
                      },
                    ),
                  ],
                ),
                trailing: GestureDetector(
                  onTap: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await widget.onTapDelete();
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: _isLoading
                      ? const SizedBox(
                          height: 20.0,
                          width: 20.0,
                          child: CircularProgressIndicator(strokeWidth: 2.0),
                        )
                      : const Icon(Icons.delete),
                ),
              ));
        }
        return const Text("No hay datos");
      },
    );
  }
}

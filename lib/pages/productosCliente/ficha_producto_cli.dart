import 'package:flutter/material.dart';

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
      color: Colors.lightBlueAccent,
      child: ListTile(
        leading: Text(
          "${producto.nombre} ${producto.precio}\$ ${producto.stock} en Stock",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        title: Text(producto.categoria),
        subtitle: Text(producto.descripcion),
        trailing: GestureDetector(
          onTap: () async {
            setState(() {
              _isLoading = true;
            });
            await widget.onTapAdd();
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
              : const Icon(Icons.add),
        ),
      ),
    );
  }
}

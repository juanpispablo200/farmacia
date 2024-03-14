import 'package:flutter/material.dart';

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/productos.dart';
import 'package:farmacia/widgets/loading_screen.dart';

class FichaProductoCar extends StatefulWidget {
  final String userId, productoId;
  final ValueChanged<int> onQuantityChange;
  final Future<Map<String, dynamic>?> carro;
  final Future<void> Function() onTapDelete;

  const FichaProductoCar({
    super.key,
    required this.carro,
    required this.userId,
    required this.productoId,
    required this.onTapDelete,
    required this.onQuantityChange,
  });

  @override
  FichaProductoCarState createState() => FichaProductoCarState();
}

class FichaProductoCarState extends State<FichaProductoCar> {
  late final Future<Producto?> _productoFuture;
  late final ValueNotifier<int> _currentQuantity = ValueNotifier<int>(1);

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _productoFuture = MongoDB.getProductoPorId(widget.productoId);
    _initializeQuantity();
  }

  Future<void> _initializeQuantity() async {
    final value = await widget.carro;
    if (value != null) {
      _currentQuantity.value = value['productos'][widget.productoId];
    }
  }

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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeading() {
    return FutureBuilder<Producto?>(
      future: _productoFuture,
      builder: (BuildContext context, AsyncSnapshot<Producto?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final producto = snapshot.data;
          return Row(
            children: [
              Text(
                producto!.nombre,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
              const SizedBox(width: 8.0),
              Text(
                "${producto.precio}\$",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
              const Spacer(),
              _buildCounter(),
              _buildRemove(),
            ],
          );
        } else {
          return const Text('Producto no encontrado');
        }
      },
    );
  }

  Widget _buildCounter() {
    return Row(children: [
      IconButton(
        icon: const Icon(Icons.remove),
        onPressed: _currentQuantity.value > 0 ? _decrementQuantity : null,
      ),
      ValueListenableBuilder<int>(
        valueListenable: _currentQuantity,
        builder: (_, value, __) => Text(
          value.toString(),
        ),
      ),
      IconButton(
        icon: const Icon(Icons.add),
        onPressed: _incrementQuantity,
      ),
    ]);
  }

  Future<void> _decrementQuantity() async {
    _currentQuantity.value--;
    await MongoDB.actualizarCantidadCr(
      widget.userId,
      widget.productoId,
      _currentQuantity.value,
    );
    widget.onQuantityChange(_currentQuantity.value);
  }

  Future<void> _incrementQuantity() async {
    _currentQuantity.value++;
    await MongoDB.actualizarCantidadCr(
      widget.userId,
      widget.productoId,
      _currentQuantity.value,
    );
    widget.onQuantityChange(_currentQuantity.value);
  }

  Widget _buildRemove() {
    return IconButton(
      onPressed: _isLoading
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await widget.onTapDelete();
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
          : const Icon(Icons.delete),
    );
  }

  void _onTap() async {
    final producto = await _productoFuture;
    if (producto != null && mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(producto.nombre),
            content: Text(producto.descripcion),
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
  }
}

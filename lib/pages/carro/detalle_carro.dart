import 'package:farmacia/widgets/loading_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mongo_dart/mongo_dart.dart' as md;

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/carro.dart';
import 'package:farmacia/pages/login_page.dart';
import 'package:farmacia/modelos/productos.dart';
import 'package:farmacia/widgets/menu_cliente.dart';
import 'package:farmacia/pages/carro/ficha_producto_carro.dart';

class DetalleCarro extends StatefulWidget {
  const DetalleCarro({Key? key}) : super(key: key);

  @override
  DetalleCarroState createState() => DetalleCarroState();
}

class DetalleCarroState extends State<DetalleCarro> {
  late Future<Map<String, dynamic>?> futureCarro;
  final valorTotalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureCarro = MongoDB.getCarroPorUsuario(Provider.of<UserProvider>(
      context,
      listen: false,
    ).userId);
  }

  @override
  void dispose() {
    valorTotalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final userId = userProvider.userId;
        futureCarro = MongoDB.getCarroPorUsuario(userId);

        return FutureBuilder(
          future: futureCarro,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            } else if (snapshot.hasError) {
              return _buildError();
            } else if (!snapshot.hasData ||
                (snapshot.hasData && snapshot.data.isEmpty)) {
              _insetarCarro(userId);
              return _buildEmptyCart();
            } else {
              Carro? carro = Carro.fromMap(snapshot.data);
              return _buildCart(userId, carro);
            }
          },
        );
      },
    );
  }

  Widget _buildError() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          "Lo sentimos existe un error de conexión",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Scaffold(
      appBar: _buildAppBar(),
      body: const Text("Se a creado un carro, porfavor vuelva a ingresar"),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Carro"),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [menuCliente(context)],
    );
  }

  Widget _buildCart(String userId, Carro? carro) {
    if (carro!.productos.isEmpty) {
      return Scaffold(
        appBar: _buildAppBar(),
        body: const Center(
          child: Text("No hay productos"),
        ),
      );
    }

    final productKeys = carro.productos.keys.toList();

    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: double.infinity,
              height: 300.0,
              child: Lottie.asset('assets/json/productos.json'),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ListView.separated(
              itemCount: carro.productos.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8.0),
              itemBuilder: (BuildContext context, int index) {
                final productId = productKeys[index];
                return SizedBox(
                  height: 55,
                  child: FichaProductoCar(
                    onTapDelete: () async =>
                        _removeProductoCarro(userId, productId),
                    userId: userId,
                    carro: futureCarro,
                    productoId: productId,
                    onQuantityChange: (value) {
                      setState(() {
                        carro.productos[productId] = value;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 50.0,
              child: _buildTotalValue(carro),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalValue(Carro? carro) {
    return FutureBuilder(
      future: MongoDB.getProductosPorCarro(carro!.productos),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Producto>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return const Text("Error al obtener productos");
        } else {
          final productos = snapshot.data;
          if (productos == null || productos.isEmpty) {
            return const Center(
              child: Text("No hay productos"),
            );
          } else {
            final valorTotal = productos.fold<double>(0, (prev, prod) {
              final cantidad = carro.productos[prod.id.toString()]!;
              return prev + (prod.precio * cantidad);
            });
            valorTotalController.text = valorTotal.toStringAsFixed(2);
            return _valorTotalInput();
          }
        }
      },
    );
  }

  void _insetarCarro(String userId) async {
    final carro = Carro(
      id: md.ObjectId(),
      productos: {},
      usuarioId: md.ObjectId.parse(userId),
    );
    await MongoDB.insertarCr(carro);
  }

  void _removeProductoCarro(String userId, String productoId) async {
    await MongoDB.removerProdCr(userId, productoId);
    setState(() {
      futureCarro = MongoDB.getCarroPorUsuario(userId);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DetalleCarro(),
        ),
      );
    });
  }

  Widget _valorTotalInput() {
    return Container(
      padding: const EdgeInsets.only(left: 20.0),
      decoration: const BoxDecoration(
        color: Colors.lightBlueAccent,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: valorTotalController,
              decoration: InputDecoration(
                hintText: "Valor total ${valorTotalController.text}",
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                prefixIcon: const Icon(
                  Icons.production_quantity_limits,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

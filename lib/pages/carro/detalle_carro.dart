import 'package:flutter/material.dart';
import 'package:farmacia/bd/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as md;

import 'package:farmacia/modelos/carro.dart';
import 'package:farmacia/pages/login_page.dart';
import 'package:farmacia/widgets/menu_cliente.dart';
import 'package:farmacia/pages/productosCliente/ficha_producto_car.dart';
import 'package:provider/provider.dart';

// import 'package:farmacia/pages/carro/ficha_carro.dart';

class DetalleCarro extends StatefulWidget {
  const DetalleCarro({Key? key}) : super(key: key);

  @override
  State<DetalleCarro> createState() => _DetalleCarroState();
}

class _DetalleCarroState extends State<DetalleCarro> {
  static const insercion = 2;

  late String userId;

  get valorTotalController => null;

  @override
  Widget build(BuildContext context) {
    userId = Provider.of<UserProvider>(context, listen: false).userId;

    var textoWidget = "Añadir Carro";
    int operacion = insercion;
    Carro? carro;

    return FutureBuilder(
      future: MongoDB.getCarroPorUsuario(userId),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.lightBlueAccent,
            child: const LinearProgressIndicator(
              backgroundColor: Colors.black87,
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            color: Colors.black,
            child: Center(
              child: Text(
                "Lo sentimos existe un error de conexión",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          );
        } else if (snapshot.hasData && snapshot.data.isEmpty) {
          _insetarCarro();
          return Scaffold(
            appBar: AppBar(
              title: const Text("Carro"),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [menuCliente(context)],
            ),
            body:
                const Text("Se a creado un carro, porfavor vuelva a ingresar"),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Carro"),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [menuCliente(context)],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      carro = Carro.fromMap(snapshot.data[index]);
                      if (carro!.productoIds.isEmpty) {
                        return const Text("No hay productos");
                      }
                      return FichaProductoCar(
                        productoId: carro!.productoIds[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  _insetarCarro() async {
    final carro = Carro(
      id: md.ObjectId(),
      productoIds: [],
      usuarioId: md.ObjectId.parse(userId),
    );
    await MongoDB.insertarCr(carro);
  }

  Widget _valorTotalInput() {
    return Container(
      margin: const EdgeInsets.only(top: 600.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        controller: valorTotalController,
        decoration: const InputDecoration(
          hintText: "Valor total --- 15",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.production_quantity_limits,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

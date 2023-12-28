import 'package:lottie/lottie.dart';
// import 'package:mongo_dart/mongo_dart.dart' as md;
import 'package:flutter/material.dart';

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/productos.dart';
import 'package:farmacia/modelos/carro.dart';
import 'package:farmacia/pages/productosCliente/ficha_producto_car.dart';
// import 'package:farmacia/pages/productosCliente/ficha_producto_cli.dart';
// import 'package:farmacia/pages/carro/ficha_carro.dart';
// import 'package:farmacia/pages/productos/ficha_producto.dart';
import 'package:farmacia/widgets/boton_atras.dart';
import 'package:farmacia/widgets/menu_cliente.dart';

class DetalleCarro extends StatefulWidget {
  const DetalleCarro({Key? key}) : super(key: key);

  @override
  State<DetalleCarro> createState() => _DetalleCarroState();
}

class _DetalleCarroState extends State<DetalleCarro> {
  static const insercion = 2;

  TextEditingController valorTotalController = TextEditingController();
  TextEditingController productoIdsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textoWidget = "Añadir Carro";
    int operacion = insercion;
    Carro? carro;

    return FutureBuilder(
      future: MongoDB.getProductos(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.deepOrange,
            child: const LinearProgressIndicator(
              backgroundColor: Colors.black87,
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            color: Colors.pink,
            child: Center(
              child: Text(
                "Lo sentimos existe un error de conexión",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          );
        } else {
          return Scaffold(
            body:
                //componentes de la pagina
                Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  width: double.infinity,
                  height: 220.0,
                  child: Lottie.asset('assets/json/ventaonline.json'),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: menuCliente(context, Colors.black),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 70.0),
                  child: backButton(context, Colors.black),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 200.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FichaProductoCar(
                          producto: Producto.fromMap(snapshot.data[index]),
                        ),
                      );
                    },
                    itemCount: snapshot.data.length,
                  ),
                ),
                _valorTotalInput(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: ElevatedButton(
                        child: const Text("Generar Pedido"),
                        onPressed: () {
                          Navigator.pushNamed(context, 'lista_productos_cli');
                          showAboutDialog(
                            context: context,
                            applicationName: 'Compra generada',
                            applicationVersion:
                                'Recuerda que el lugar de retiro es en las instalaciones de la UIDE tus productos estaran disponibles 3 DIAS para retirar caso contrario volveran estar disponibles para la VENTA ',
                          );
                        }),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }

  _eliminarProducto(Carro carro) async {
    await MongoDB.eliminarCr(carro);
    setState(() {});
  }

  Widget _valorTotalInput() {
    return Container(
      margin: const EdgeInsets.only(top: 600.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 194, 0, 0.8),
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        controller: valorTotalController,
        decoration: const InputDecoration(
          hintText: "Valor total --- 15",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.production_quantity_limits,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

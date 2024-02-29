import 'package:farmacia/widgets/appbar_cli.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/pages/login_page.dart';
import 'package:farmacia/modelos/productos.dart';
import 'package:farmacia/widgets/loading_screen.dart';
import 'package:farmacia/pages/carro/detalle_carro.dart';
import 'package:farmacia/pages/productosCliente/ficha_producto_cli.dart';

class ListaProductosCli extends StatefulWidget {
  const ListaProductosCli({Key? key}) : super(key: key);

  @override
  State<ListaProductosCli> createState() => _ListaProductosCliState();
}

class _ListaProductosCliState extends State<ListaProductosCli> {
  late String userId;

  @override
  Widget build(BuildContext context) {
    userId = Provider.of<UserProvider>(context, listen: false).userId;

    return FutureBuilder(
      future: MongoDB.getProductos(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
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
            appBar: const AppBarCli(title: 'Productos'),
            body: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 300.0,
                  child: Lottie.asset('assets/json/productos.json'),
                ),
                ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FichaProductoCli(
                        producto: Producto.fromMap(snapshot.data[index]),
                        onTapAdd: () => _agregarProducto(
                          userId,
                          Producto.fromMap(snapshot.data[index]),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const DetalleCarro();
                })).then((value) => setState(() {}));
              },
              child: const Icon(
                Icons.shopping_bag,
              ),
            ),
          );
        }
      },
    );
  }

  _agregarProducto(String userId, Producto producto) async {
    await MongoDB.insertarProdCr(userId, producto);
    setState(() {});
  }
}

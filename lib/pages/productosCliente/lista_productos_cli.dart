import 'package:farmacia/pages/login_page.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/productos.dart';
import 'package:farmacia/pages/carro/detalle_carro.dart';
import 'package:farmacia/pages/productosCliente/ficha_producto_cli.dart';
import 'package:farmacia/widgets/menu_cliente.dart';
import 'package:provider/provider.dart';

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
          return Container(
            color: Colors.lightBlueAccent,
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
            appBar: AppBar(
              title: const Text("Produtos"),
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushNamed(context, 'login');
                  }),
              actions: [menuCliente(context)],
            ),
            body: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 150.0,
                  child: Lottie.asset('assets/json/productos.json'),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 150.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FichaProductoCli(
                          producto: Producto.fromMap(snapshot.data[index]),
                          onTapAdd: () async {
                            _agregarProducto(
                              userId,
                              Producto.fromMap(snapshot.data[index]),
                            );
                          },
                        ),
                      );
                    },
                    itemCount: snapshot.data.length,
                  ),
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
              child: const Icon(Icons.shopping_bag),
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

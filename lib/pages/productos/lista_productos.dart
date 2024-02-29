import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:farmacia/widgets/appbar.dart';

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/productos.dart';
import 'package:farmacia/widgets/loading_screen.dart';
import 'package:farmacia/pages/productos/ficha_producto.dart';
import 'package:farmacia/pages/productos/nuevo_producto.dart';

class ListaProductos extends StatefulWidget {
  const ListaProductos({Key? key}) : super(key: key);

  @override
  State<ListaProductos> createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {
  late Future _productosFuture;

  @override
  void initState() {
    super.initState();
    _productosFuture = _fetchProductos();
  }

  Future _fetchProductos() => MongoDB.getProductos();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _productosFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return _buildErrorWidget(context);
        } else {
          return _buildMainWidget(snapshot);
        }
      },
    );
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Container(
      color: Colors.pink,
      child: Center(
        child: Text(
          "Lo sentimos existe un error de conexión",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }

  Widget _buildMainWidget(AsyncSnapshot snapshot) {
    return Scaffold(
      appBar: const AppBarAdmin(title: "Productos Admin"),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 300.0,
            child: Lottie.asset('assets/json/productos.json'),
          ),
          ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: FichaProducto(
                  producto: Producto.fromMap(snapshot.data[index]),
                  onTapDelete: () async {
                    _eliminarProducto(Producto.fromMap(snapshot.data[index]));
                  },
                  onTapEdit: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const NuevoProducto();
                        },
                        settings: RouteSettings(
                          arguments: Producto.fromMap(snapshot.data[index]),
                        ),
                      ),
                    );
                    _productosFuture = _fetchProductos();
                    setState(() {});
                  },
                ),
              );
            },
            itemCount: snapshot.data.length,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return const NuevoProducto();
          })).then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _eliminarProducto(Producto producto) async {
    await MongoDB.eliminarP(producto);
    _productosFuture = _fetchProductos();
    setState(() {});
  }
}

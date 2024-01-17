import 'package:flutter/material.dart';

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/productos.dart';
import 'package:farmacia/pages/productos/ficha_producto.dart';
import 'package:farmacia/pages/productos/nuevo_producto.dart';
import 'package:farmacia/widgets/menu_cliente.dart';

class ListaProductos extends StatefulWidget {
  const ListaProductos({Key? key}) : super(key: key);

  @override
  State<ListaProductos> createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {
  @override
  Widget build(BuildContext context) {
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
              title: const Text("Productos Admin"),
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushNamed(context, 'lista_usuarios');
                  }),
              actions: [menuCliente(context)],
            ),
            body:
                //componentes de la pagina
                Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 100.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FichaProducto(
                          producto: Producto.fromMap(snapshot.data[index]),
                          onTapDelete: () async {
                            _eliminarProducto(
                                Producto.fromMap(snapshot.data[index]));
                          },
                          onTapEdit: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const NuevoProducto();
                                    },
                                    settings: RouteSettings(
                                      arguments: Producto.fromMap(
                                          snapshot.data[index]),
                                    ))).then((value) => setState(() {}));
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
                  return const NuevoProducto();
                })).then((value) => setState(() {}));
              },
              child: const Icon(Icons.add),
            ),
          );
        }
      },
    );
  }

  _eliminarProducto(Producto producto) async {
    await MongoDB.eliminarP(producto);
    setState(() {});
  }
}

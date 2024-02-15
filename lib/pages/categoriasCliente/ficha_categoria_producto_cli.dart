import 'package:flutter/material.dart';

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/productos.dart';
import 'package:farmacia/modelos/categorias.dart';
import 'package:farmacia/widgets/loading_screen.dart';

class FichaCategoriaProducto extends StatelessWidget {
  final Categoria categoria;

  const FichaCategoriaProducto({
    Key? key,
    required this.categoria,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MongoDB.getProductosPorCategoria(categoria),
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
    final List<Producto> productos =
        (snapshot.data as List).map((item) => Producto.fromMap(item)).toList();

    return Scaffold(
      body: Column(
        children: [
          Text(
            categoria.nombre,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
              itemCount: productos.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 2.0,
                    color: const Color.fromARGB(174, 64, 195, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ListTile(
                      title: Text(productos[index].nombre),
                      subtitle: Text(productos[index].descripcion),
                      trailing: Text("${productos[index].precio.toString()}\$"),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

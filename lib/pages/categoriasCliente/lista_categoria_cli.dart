import 'package:flutter/material.dart';

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/categorias.dart';
import 'package:farmacia/widgets/appbar_cli.dart';
import 'package:farmacia/widgets/loading_screen.dart';
import 'package:farmacia/pages/categoriasCliente/ficha_categoria_producto_cli.dart';

class ListaCategoriasCli extends StatefulWidget {
  const ListaCategoriasCli({Key? key}) : super(key: key);

  @override
  State<ListaCategoriasCli> createState() => _ListaCategoriasCliState();
}

class _ListaCategoriasCliState extends State<ListaCategoriasCli> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MongoDB.getCategorias(),
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
      appBar: const AppBarCli(
        title: 'Categorias',
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              final Categoria categoria =
                  Categoria.fromMap(snapshot.data[index]);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 290,
                  child: FichaCategoriaProducto(categoria: categoria),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

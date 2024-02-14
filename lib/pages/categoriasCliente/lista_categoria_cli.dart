import 'package:flutter/material.dart';

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/widgets/menu_cliente.dart';
import 'package:farmacia/widgets/loading_screen.dart';

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
                    Navigator.pushNamed(context, 'lista_productos_cli');
                  }),
              actions: [menuCliente(context)],
            ),
            body: Text("hello world ${snapshot.data}"),
          );
        }
      },
    );
  }
}

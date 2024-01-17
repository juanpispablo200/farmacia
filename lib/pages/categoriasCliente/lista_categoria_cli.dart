import 'package:flutter/material.dart';

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/categorias.dart';
import 'package:farmacia/widgets/menu_cliente.dart';
import 'package:farmacia/pages/categoriasCliente/ficha_categoria_cli.dart';

class ListaCategoriasCli extends StatefulWidget {
  const ListaCategoriasCli({Key? key}) : super(key: key);

  @override
  State<ListaCategoriasCli> createState() => _ListaCategoriasCliState();
}

class _ListaCategoriasCliState extends State<ListaCategoriasCli> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Categorias"),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(context, 'lista_productos_cli');
              }),
          actions: [menuCliente(context)],
        ),
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15.0),
              child: FutureBuilder(
                future: MongoDB.getCategorias(),
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
                          "Lo sentimos existe un error de conexión: ${snapshot.error}",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      children: snapshot.data.map<Widget>((categoria) {
                        return Column(
                          children: [
                            Text(categoria['nombre'],
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            ProductDropdown(
                                categoria: Categoria.fromMap(categoria)),
                          ],
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}

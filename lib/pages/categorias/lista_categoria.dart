import 'package:farmacia/widgets/appbar.dart';
import 'package:farmacia/widgets/loading_screen.dart';
import 'package:flutter/material.dart';

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/categorias.dart';
import 'package:farmacia/pages/categorias/ficha_categoria.dart';
import 'package:farmacia/pages/categorias/nueva_categoria.dart';

class ListaCategorias extends StatefulWidget {
  const ListaCategorias({Key? key}) : super(key: key);

  @override
  State<ListaCategorias> createState() => _ListaCategoriasState();
}

class _ListaCategoriasState extends State<ListaCategorias> {
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
            appBar: const AppBarAdmin(
              title: "Categorias Admin",
            ),
            body: Stack(
              children: [
                ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FichaCategoria(
                        categoria: Categoria.fromMap(snapshot.data[index]),
                        onTapDelete: () async {
                          _eliminarCategoria(
                              Categoria.fromMap(snapshot.data[index]));
                        },
                        onTapEdit: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const NuevaCategoria();
                                  },
                                  settings: RouteSettings(
                                    arguments:
                                        Categoria.fromMap(snapshot.data[index]),
                                  ))).then((value) => setState(() {}));
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
                  return const NuevaCategoria();
                })).then((value) => setState(() {}));
              },
              child: const Icon(Icons.add),
            ),
          );
        }
      },
    );
  }

  _eliminarCategoria(Categoria categoria) async {
    await MongoDB.eliminarC(categoria);
    setState(() {});
  }
}

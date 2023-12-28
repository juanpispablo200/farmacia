import 'package:flutter/material.dart';

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/categorias.dart';
import 'package:farmacia/pages/categorias/ficha_categoria.dart';
import 'package:farmacia/pages/categorias/nueva_categoria.dart';
import 'package:farmacia/widgets/boton_atras.dart';
import 'package:lottie/lottie.dart';

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
                  width: double.infinity,
                  height: 250.0,
                  child: Lottie.asset('assets/json/categorias.json'),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: backButton(context, Colors.black),
                ),
                Container(
                  margin: EdgeInsets.only(top: 200.0),
                  child: ListView.builder(
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
                                      return NuevaCategoria();
                                    },
                                    settings: RouteSettings(
                                      arguments: Categoria.fromMap(
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
                  return NuevaCategoria();
                })).then((value) => setState(() {}));
              },
              child: Icon(Icons.add),
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

import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/categorias.dart';
import 'package:farmacia/pages/categoriasCliente/ficha_categoria_cli.dart';
import 'package:farmacia/pages/productosCliente/lista_productos_cli.dart';
import 'package:farmacia/widgets/boton_atras.dart';
import 'package:farmacia/widgets/menu_cliente.dart';

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
                  margin: EdgeInsets.only(top: 60.0),
                  width: double.infinity,
                  height: 200.0,
                  child: Lottie.asset('assets/json/categorias.json'),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25.0),
                  child: menuCliente(context, Colors.black),
                ),
                Container(
                  margin: EdgeInsets.only(top: 70.0),
                  child: backButton(context, Colors.black),
                ),
                Container(
                  margin: EdgeInsets.only(top: 200.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FichaCategoriaCli(
                          categoria: Categoria.fromMap(snapshot.data[index]),
                          onTapAdd: () async {
                            _eliminarCategoria(
                                Categoria.fromMap(snapshot.data[index]));
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
                  return ListaProductosCli();
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

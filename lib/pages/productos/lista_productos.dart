//import 'package:flutter/material.dart';
//import 'package:restaurante/bd/mongodb.dart';
//import 'package:restaurante/modelos/productos.dart';
//import 'package:restaurante/pages/productos/ficha_producto.dart';
//import 'package:restaurante/pages/productos/nuevo_producto.dart';
///import 'package:restaurante/widgets/boton_atras.dart';
///import 'package:restaurante/widgets/menu_cliente.dart';
///import 'package:lottie/lottie.dart';

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
            color: Colors.deepOrange,
            child: const LinearProgressIndicator(
              backgroundColor: Colors.black87,
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            color: Colors.pink,
            child: Center(
              child: Text("Lo sentimos existe un error de conexión",
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineLarge,
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
                  margin: EdgeInsets.only(top: 80.0),
                  width: double.infinity,
                  height: 150.0,
                  child: Lottie.asset('assets/json/productos.json'),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25.0),
                  child: menuCliente (context,Colors.black ),
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
                        child: FichaProducto(
                          producto: Producto.fromMap(snapshot.data[index]),
                          onTapDelete: () async {
                            _eliminarProducto(Producto.fromMap(snapshot.data[index]));
                          },
                          onTapEdit: () async {
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (BuildContext context){
                                      return NuevoProducto();},
                                    settings: RouteSettings(
                                      arguments: Producto.fromMap(snapshot.data[index]),
                                    ))).then((value) => setState((){}));

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
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (BuildContext context){
                          return NuevoProducto();
                        })).then((value) => setState((){}));
              },
              child: Icon(Icons.add),
            ),
          );
        }
      },
    );
  }
  _eliminarProducto(Producto producto) async{
    await MongoDB.eliminarP(producto);
    setState(() {});
  }
}
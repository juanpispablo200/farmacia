import 'package:flutter/material.dart';
//import 'package:restaurante/bd/mongodb.dart';
///import 'package:restaurante/modelos/productos.dart';
///import 'package:restaurante/pages/carro/detalle_carro.dart';
///import 'package:restaurante/pages/productosCliente/ficha_producto_cli.dart';
///import 'package:restaurante/widgets/boton_atras.dart';
//import 'package:restaurante/widgets/menu_cliente.dart';
///import 'package:lottie/lottie.dart';

class ListaProductosCli extends StatefulWidget {
  const ListaProductosCli({Key? key}) : super(key: key);

  @override
  State<ListaProductosCli> createState() => _ListaProductosCliState();
}

class _ListaProductosCliState extends State<ListaProductosCli> {
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
                  margin: EdgeInsets.only(top: 30.0),
                  child: menuCliente (context,Colors.black ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 70.0),
                  child: backButton(context, Colors.black),

                ),

                Container(
                  margin: EdgeInsets.only(top: 225.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FichaProductoCli(
                          producto: Producto.fromMap(snapshot.data[index]),
                          onTapAdd: () async {
                            _agregarProducto(Producto.fromMap(snapshot.data[index]));
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
                          return DetalleCarro();
                        })).then((value) => setState((){}));
              },
              child: Icon(Icons.car_crash),
            ),
          );
        }
      },
    );
  }
  _agregarProducto(Producto producto) async{
    await MongoDB.eliminarP(producto);
    setState(() {});
  }
}
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mongo_dart/mongo_dart.dart' as md;

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/categorias.dart';
import 'package:farmacia/widgets/boton_atras.dart';

class NuevaCategoria extends StatefulWidget {
  const NuevaCategoria({Key? key}) : super(key: key);

  @override
  State<NuevaCategoria> createState() => _NuevaCategoriaState();
}

class _NuevaCategoriaState extends State<NuevaCategoria> {
  static const edicion = 1;
  static const insercion = 2;

  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textoWidget = "Añadir Categoria";
    int operacion = insercion;
    Categoria? categoria;

    if (ModalRoute.of(context)?.settings.arguments != null) {
      operacion = edicion;
      categoria = ModalRoute.of(context)?.settings.arguments as Categoria;
      nombreController.text = categoria.nombre;
      descripcionController.text = categoria.descripcion;
      //producto_idsController.text = categoria.producto_ids;
      textoWidget = "Editar Categoria";
    }
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 150.0,
                    child: Lottie.asset('assets/json/categorias.json'),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40.0),
                    child: backButton(context, Colors.black),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40.0),
                  )
                ],
              ),
              // agregar un componente que permita
              Transform.translate(
                offset: const Offset(0.0, -20.0),
                child: Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  width: double.infinity,
                  height: 630.0,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Text(
                          "Crea una nueva categoria",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                          ),
                        ),

                        //vamos a agregar los textfieldd para el correo y contra
                        // vamos agregar widgets propios para el proyecto
                        _nombreInput(),
                        _descripcionInput(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: ElevatedButton(
                              child: Text(textoWidget),
                              onPressed: () {
                                if (operacion == edicion) {
                                  // editar el objeto
                                  _actualizarCategoria(categoria!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Registro actualizado Correctamente')),
                                  );
                                } else {
                                  //Insertar el componente
                                  _insetarCategoria();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Registro con exito Categoria')),
                                  );
                                }
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _insetarCategoria() async {
    final categoria = Categoria(
      id: md.ObjectId(),
      nombre: nombreController.text,
      descripcion: descripcionController.text,
    );
    await MongoDB.insertarC(categoria);
  }

  _actualizarCategoria(Categoria categoria) async {
    final categoriaActulizada = Categoria(
      id: categoria.id,
      nombre: nombreController.text,
      descripcion: descripcionController.text,
    );

    await MongoDB.actualizarC(categoriaActulizada);
  }

  //widget para el correo
  Widget _nombreInput() {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 194, 0, 0.8),
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        controller: nombreController,
        decoration: const InputDecoration(
          hintText: "Nombre Categoria",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget _descripcionInput() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 194, 0, 0.8),
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        controller: descripcionController,
        decoration: const InputDecoration(
          hintText: "Descripcion",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.verified_user_outlined,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }
}

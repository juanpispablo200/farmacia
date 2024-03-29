import 'package:farmacia/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as md;

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/categorias.dart';

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
      textoWidget = "Editar Categoria";
    }
    return Scaffold(
      appBar: const AppBarAdmin(
        title: 'Nueva Categoria',
        showMenu: false,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40.0),
                  )
                ],
              ),
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
                        _nombreInput(),
                        _descripcionInput(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: ElevatedButton(
                              child: Text(textoWidget),
                              onPressed: () async {
                                final scaffoldMessenger =
                                    ScaffoldMessenger.of(context);
                                if (operacion == edicion) {
                                  // editar el objeto
                                  await _actualizarCategoria(categoria!);
                                  scaffoldMessenger.showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Registro actualizado Correctamente')),
                                  );
                                } else {
                                  await _insetarCategoria();
                                  scaffoldMessenger.showSnackBar(
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

  Widget _nombreInput() {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
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
          color: Colors.lightBlueAccent,
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

//import 'package:flutter/material.dart';
///import 'package:lottie/lottie.dart';
//import 'package:restaurante/bd/mongodb.dart';
///import 'package:restaurante/modelos/categorias.dart';
///import 'package:restaurante/widgets/boton_atras.dart';
///import 'package:mongo_dart/mongo_dart.dart' as MD;

class NuevaCategoria extends StatefulWidget {
  const NuevaCategoria({Key? key}) : super(key: key);

  @override
  State<NuevaCategoria> createState() => _NuevaCategoriaState();
}

class _NuevaCategoriaState extends State<NuevaCategoria> {

  static const EDICION =1;
  static const INSERCION = 2;

  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var textoWidget = "Añadir Categoria";
    int operacion = INSERCION;
    Categoria? categoria;

    if (ModalRoute.of(context)?.settings.arguments != null){
      operacion = EDICION;
      categoria = ModalRoute.of(context)?.settings.arguments as Categoria;
      nombreController.text = categoria.nombre;
      descripcionController.text = categoria.descripcion;
      //producto_idsController.text = categoria.producto_ids;
      textoWidget = "Editar Categoria";
    }
    return Scaffold(
      body:
      ListView(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 150.0,
                    child: Lottie.asset('assets/json/categorias.json'),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40.0),
                    child: backButton(context, Colors.black),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40.0),
                  )
                ],
              ),
              // agregar un componente que permita
              Transform.translate(
                offset: Offset(0.0, -20.0),
                child: Container(
                  margin: EdgeInsets.only(top: 20.0),
                  width: double.infinity,
                  height: 630.0,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text("Crea una nueva categoria",
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
                        Container(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                              child: ElevatedButton(
                                child: Text(textoWidget),
                                onPressed: (){
                                  if (operacion == EDICION){
                                    // editar el objeto
                                    _actualizarCategoria(categoria!);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Registro actualizado Correctamente')),
                                    );
                                  } else {
                                    //Insertar el componente
                                    _insetarCategoria();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Registro con exito Categoria')),
                                    );
                                  }
                                  Navigator.pop(context);
                                },
                              ),
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
  _insetarCategoria() async{
    final categoria = Categoria(
      id: MD.ObjectId(),
      nombre: nombreController.text,
      descripcion: descripcionController.text,

    );
    await MongoDB.insertarC(categoria);
  }
  _actualizarCategoria (Categoria categoria) async {
    final u = Categoria(
      id: categoria.id,
      nombre: nombreController.text,
      descripcion: descripcionController.text,

    );
  }
  //widget para el correo
  Widget _nombreInput(){
    return Container(
      margin: EdgeInsets.only(top:15.0),
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 194, 0, 0.8),
          borderRadius: BorderRadius.circular(20.0)
      ),
      child: TextField(
        controller: nombreController,
        decoration: InputDecoration(
          hintText: "Nombre Categoria",
          border: OutlineInputBorder(
              borderSide: BorderSide.none
          ),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
  Widget _descripcionInput(){
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 194, 0, 0.8),
          borderRadius: BorderRadius.circular(20.0)
      ),
      child: TextField(
        controller: descripcionController,
        decoration: InputDecoration(
          hintText: "Descripccion",
          border: OutlineInputBorder(
              borderSide: BorderSide.none
          ),
          prefixIcon: Icon(
            Icons.verified_user_outlined,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }
}


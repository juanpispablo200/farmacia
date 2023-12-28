import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/usuarios.dart';
import 'package:farmacia/widgets/boton_atras.dart';
import 'package:mongo_dart/mongo_dart.dart' as md;

class RegistroPage extends StatefulWidget {
  const RegistroPage({Key? key}) : super(key: key);

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  static const edicion = 1;
  static const insercion = 2;

  TextEditingController nombresController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  TextEditingController cedulaController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController carreraController = TextEditingController();
  TextEditingController rolController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textoWidget = "Añadir usuario";
    int operacion = insercion;
    Usuario? usuario;

    if (ModalRoute.of(context)?.settings.arguments != null) {
      operacion = edicion;
      usuario = ModalRoute.of(context)?.settings.arguments as Usuario;
      nombresController.text = usuario.nombres;
      apellidosController.text = usuario.apellidos;
      cedulaController.text = usuario.cedula;
      correoController.text = usuario.correo;
      telefonoController.text = usuario.telefono;
      passwordController.text = usuario.password;
      carreraController.text = usuario.carrera;
      rolController.text = 'cliente';
      textoWidget = "Editar Usuario";
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
                    child: Lottie.asset('assets/json/registro.json'),
                  ),
                  /*Container(
                    margin: EdgeInsets.only(top: 40.0),
                    child: Image(
                        width: double.infinity,
                        height: 350.0,
                        fit: BoxFit.cover,
                        image:  AssetImage ('assets/img/Restaurante.png')
                    ),
                  ),*/
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
                          "Registrate para acceder a los servicios",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                          ),
                        ),

                        //vamos a agregar los textfieldd para el correo y contra
                        // vamos agregar widgets propios para el proyecto
                        _nombresInput(),
                        _apellidosInput(),
                        _cedulaInput(),
                        _emailInput(),
                        _telefonoInput(),
                        _carreraInput(),
                        _passwordInput(),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: ElevatedButton(
                              child: Text(textoWidget),
                              onPressed: () {
                                if (operacion == edicion) {
                                  // editar el objeto
                                  _actualizar(usuario!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Registro actualizado Correctamente')),
                                  );
                                } else {
                                  //Insertar el componente
                                  _insetarUsuario();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Registro con exito')),
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

  _insetarUsuario() async {
    final usuario = Usuario(
      id: md.ObjectId(),
      nombres: nombresController.text,
      apellidos: apellidosController.text,
      cedula: cedulaController.text,
      telefono: telefonoController.text,
      correo: correoController.text,
      password: passwordController.text,
      carrera: carreraController.text,
      rol: 'cliente',
    );
    await MongoDB.insertar(usuario);
  }

  _actualizar(Usuario usuario) async {
    final usuarioActulizado = Usuario(
      id: usuario.id,
      nombres: nombresController.text,
      apellidos: apellidosController.text,
      cedula: cedulaController.text,
      correo: correoController.text,
      password: passwordController.text,
      telefono: telefonoController.text,
      carrera: carreraController.text,
      rol: rolController.text,
    );
  }

  //widget para el correo
  Widget _nombresInput() {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 194, 0, 0.8),
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        controller: nombresController,
        decoration: const InputDecoration(
          hintText: "Nombres usuario",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget _apellidosInput() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 194, 0, 0.8),
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        controller: apellidosController,
        decoration: const InputDecoration(
          hintText: "Apellidos usuario",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.verified_user_outlined,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }

  Widget _cedulaInput() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 194, 0, 0.8),
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        controller: cedulaController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: "Cedula",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.person_2_rounded,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }

  Widget _emailInput() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 194, 0, 0.8),
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        controller: correoController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: "Correo Electronico",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.email,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }

  Widget _telefonoInput() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 194, 0, 0.8),
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        controller: telefonoController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: "Telefono",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.phone,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }

  Widget _passwordInput() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 194, 0, 0.8),
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        controller: passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: "Contraseña",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.key,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }

  Widget _carreraInput() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 194, 0, 0.8),
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        controller: carreraController,
        decoration: const InputDecoration(
          hintText: "Escuela",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.home_filled,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }

  Widget _rolInput() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 194, 0, 0.8),
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        controller: rolController,
        decoration: const InputDecoration(
          hintText: "Rol",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.check,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }
}

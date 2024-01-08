import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:farmacia/widgets/boton_atras.dart';
import 'package:farmacia/utilitarios/logger.dart';
import 'package:farmacia/modelos/usuarios.dart';
import 'package:farmacia/bd/mongodb.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Usuario? usuario;
    if (ModalRoute.of(context)?.settings.arguments != null) {
      usuario = ModalRoute.of(context)?.settings.arguments as Usuario;
      _correoController.text = usuario.correo;
      _passwordController.text = usuario.password;
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
                    height: 300.0,
                    child: Lottie.asset('assets/json/login.json'),
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
              Transform.translate(
                offset: const Offset(0.0, -20.0),
                child: Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  width: double.infinity,
                  height: 450.0,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Text(
                          "Bienvenidos a la Farmacia UIDE",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 30.0,
                          ),
                        ),
                        const Text(
                          "Inicia sesión para acceder",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 10.0,
                          ),
                        ),
                        _emailInput(),
                        _passwordInput(),
                        _loginButton(context),
                        Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          child: const Text(
                            'Olvidaste tu contraseña?',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Aun no tienes cuenta?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.0,
                                ),
                              ),
                              const SizedBox(width: 20.0),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, 'registro');
                                },
                                child: const Text(
                                  'Registrate',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
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

  Widget _emailInput() {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.only(left: 30.0),
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(30.0)),
      child: TextField(
        controller: _correoController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: "Correo Electronico",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.email,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
  // widget para el password

  Widget _passwordInput() {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.only(left: 30.0),
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(30.0)),
      child: TextField(
        controller: _passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: "Contraseña",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.key,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Container(
      width: 350.0,
      height: 50.0,
      margin: const EdgeInsets.only(top: 40.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlueAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
        onPressed: () {
          String correo = _correoController.text;
          String password = _passwordController.text;
          MongoDB.autenticarUsuarios(correo, password).then((resultado) {
            log.i(resultado);
            if (resultado['exito'] == true) {
              if (resultado['rol'] == 'cliente') {
                Navigator.pushNamed(context, 'lista_productos_cli');
              }
              if (resultado['rol'] == 'admin') {
                Navigator.pushNamed(context, 'lista_usuarios');
              }
            } else {
              log.i(resultado);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('El usuario no existe, Registrate')),
              );
            }
          });
        },
        child: const Text(
          'Ingresar',
          style: TextStyle(fontSize: 30.0, color: Colors.black),
        ),
      ),
    );
  }
}

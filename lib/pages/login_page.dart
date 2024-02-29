import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:farmacia/bd/mongodb.dart';

class UserProvider with ChangeNotifier {
  String _userId = '';

  String get userId => _userId;

  void setUserId(String id) {
    id = id.substring(10, 34);
    _userId = id;
    notifyListeners();
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(31, 162, 255, 1),
              Color.fromRGBO(18, 216, 250, 1),
              Color.fromRGBO(166, 255, 203, 1),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Lottie.asset('assets/json/login.json'),
              ),
              Card(
                color: const Color.fromRGBO(255, 255, 255, 0.63),
                shadowColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _emailInput(),
                      const SizedBox(height: 16.0),
                      _passwordInput(),
                      const SizedBox(height: 16.0),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.only(left: 30.0),
      child: TextField(
        controller: _correoController,
        style: const TextStyle(color: Colors.black),
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: "Correo Electronico",
          hintStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.email,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _passwordInput() {
    return Container(
      padding: const EdgeInsets.only(left: 30.0),
      margin: const EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextField(
        controller: _passwordController,
        style: const TextStyle(color: Colors.black),
        obscureText: true,
        decoration: const InputDecoration(
          hintText: "Contraseña",
          hintStyle: TextStyle(color: Colors.black),
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
          elevation: 10,
          backgroundColor: Colors.lightBlueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: () {
          String correo = _correoController.text;
          String password = _passwordController.text;

          MongoDB.autenticarUsuarios(correo, password).then((resultado) {
            if (resultado['exito'] == true) {
              Provider.of<UserProvider>(context, listen: false)
                  .setUserId(resultado['_id']);
              if (resultado['rol'] == 'cliente') {
                Navigator.pushNamed(context, 'lista_productos_cli');
              }
              if (resultado['rol'] == 'admin') {
                Navigator.pushNamed(context, 'lista_usuarios');
              }
            } else {
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

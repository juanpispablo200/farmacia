import 'package:flutter/material.dart';

import 'package:farmacia/widgets/menu_cliente.dart';

class PerfilClientePage extends StatefulWidget {
  const PerfilClientePage({Key? key}) : super(key: key);

  @override
  State<PerfilClientePage> createState() => _PerfilClienteState();
}

class _PerfilClienteState extends State<PerfilClientePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil de Usuario"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, 'login');
            }),
        actions: [menuCliente(context)],
      ),
      body:
          //componentes de la pagina
          Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 100.0),
            child: ListView(
              children: [
                SizedBox(
                  width: 100.0, // Adjust the value as needed
                  height: 100.0, // Adjust the value as needed
                  child: Image.asset('assets/img/avatar.png'),
                ),
                const Center(
                  child: Text(
                    "Datos Personales",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    "Nombres: Kevin Andres",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    "Apellidos: Suarez Armijos",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    "Correo: kesuarezar@uide.edu.ec",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    "Cedula: 0959403201",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    "Telefono: 0959403201",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    "Carrera: Ingenieria en Software",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

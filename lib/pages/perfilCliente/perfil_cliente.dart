import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/usuarios.dart';
import 'package:farmacia/widgets/loading_screen.dart';
import 'package:farmacia/widgets/menu_cliente.dart';
import 'package:farmacia/pages/login_page.dart';

class PerfilClientePage extends StatefulWidget {
  const PerfilClientePage({Key? key}) : super(key: key);

  @override
  State<PerfilClientePage> createState() => PerfilClienteState();
}

class PerfilClienteState extends State<PerfilClientePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final userId = userProvider.userId;
        final usuario = MongoDB.getUsuarioPorId(userId);

        return FutureBuilder<Usuario?>(
          future: usuario,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 31, 162, 255),
                      Color.fromARGB(255, 18, 216, 250),
                      Color.fromARGB(255, 166, 255, 203),
                    ],
                  ),
                ),
                child: Scaffold(
                  backgroundColor: Colors
                      .transparent, // Make the Scaffold background transparent
                  appBar: AppBar(
                    title: const Text("Perfil"),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    actions: [menuCliente(context)],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        _buildProfileInfo(snapshot.data!),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget _buildProfileInfo(Usuario usuario) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black,
              width: 3.0,
            ),
          ),
          child: Image.asset(
            'assets/img/avatar.png',
            height: 200,
            fit: BoxFit.fitHeight,
          ),
        ),
        _buildCard('Nombre', usuario.nombres),
        _buildCard('Apellidos', usuario.apellidos),
        _buildCard('Cédula', usuario.cedula),
        _buildCard('Correo', usuario.correo),
        _buildCard('Teléfono', usuario.telefono),
        _buildCard('Carrera', usuario.carrera),
        _buildCard('Rol', usuario.rol),
      ],
    );
  }

  Card _buildCard(String title, String subtitle) {
    return Card(
      color: Colors.white.withOpacity(0.7),
      margin: const EdgeInsets.all(8.0),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
      ),
    );
  }
}

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/usuarios.dart';
import 'package:flutter/material.dart';
import 'package:farmacia/pages/login_page.dart';

import 'package:provider/provider.dart';
import 'package:farmacia/widgets/menu_cliente.dart';

class PerfilClientePage extends StatefulWidget {
  const PerfilClientePage({Key? key}) : super(key: key);

  @override
  State<PerfilClientePage> createState() => _PerfilClienteState();
}

class _PerfilClienteState extends State<PerfilClientePage> {
  late Future<Usuario?> usuario;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userId = Provider.of<UserProvider>(context, listen: false).userId;
    usuario = MongoDB.getUsuarioPorId(userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Usuario?>(
      future: usuario,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading indicator while waiting for data
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Show error message if there's an error
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Perfil"),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushNamed(context, 'lista_productos_cli');
                },
              ),
              actions: [menuCliente(context)],
            ),
            body: ListView(
              children: [
                Column(
                  children: [
                    Transform.translate(
                      offset: const Offset(0.0, -20.0),
                      child: Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100.0,
                              child: Image.asset('assets/img/avatar.png',
                                  fit: BoxFit.cover),
                            ),
                            ListTile(
                              title: const Text('Nombre'),
                              subtitle: Text(snapshot.data!.nombres),
                            ),
                            ListTile(
                              title: const Text('Correo'),
                              subtitle: Text(snapshot.data!.correo),
                            ),
                            ListTile(
                              title: const Text('Contraseña'),
                              subtitle: Text(snapshot.data!.password),
                            ),
                            ListTile(
                              title: const Text('Teléfono'),
                              subtitle: Text(snapshot.data!.telefono),
                            ),
                            ListTile(
                              title: const Text('Cédula'),
                              subtitle: Text(snapshot.data!.cedula),
                            ),
                            ListTile(
                              title: const Text('Carrera'),
                              subtitle: Text(snapshot.data!.carrera),
                            ),
                            ListTile(
                              title: const Text('Rol'),
                              subtitle: Text(snapshot.data!.rol),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

import 'package:farmacia/widgets/loading_screen.dart';
import 'package:flutter/material.dart';

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/usuarios.dart';
import 'package:farmacia/pages/usuarios/ficha_usuario.dart';
import 'package:farmacia/pages/usuarios/registro_page.dart';
import 'package:farmacia/widgets/menu_admin.dart';
import 'package:lottie/lottie.dart';

class ListaUsuarios extends StatefulWidget {
  const ListaUsuarios({Key? key}) : super(key: key);

  @override
  State<ListaUsuarios> createState() => _ListaUsuariosState();
}

class _ListaUsuariosState extends State<ListaUsuarios> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MongoDB.getUsuarios(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Container(
            color: Colors.pink,
            child: Center(
              child: Text(
                "Lo sentimos existe un error de conexión",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Usuarios Admin"),
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushNamed(context, 'login');
                  }),
              actions: [
                menuAdmin(context),
              ],
            ),
            body: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 300.0,
                  child: Lottie.asset('assets/json/usuario.json'),
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FichaUsuario(
                        usuario: Usuario.fromMap(snapshot.data[index]),
                        onTapDelete: () async {
                          _eliminarUsuario(
                              Usuario.fromMap(snapshot.data[index]));
                        },
                        onTapEdit: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const RegistroPage();
                                  },
                                  settings: RouteSettings(
                                    arguments:
                                        Usuario.fromMap(snapshot.data[index]),
                                  ))).then((value) => setState(() {}));
                        },
                      ),
                    );
                  },
                  itemCount: snapshot.data.length,
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const RegistroPage();
                })).then((value) => setState(() {}));
              },
              child: const Icon(Icons.add),
            ),
          );
        }
      },
    );
  }

  _eliminarUsuario(Usuario usuario) async {
    await MongoDB.eliminar(usuario);
    setState(() {});
  }
}

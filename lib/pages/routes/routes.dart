import 'package:farmacia/pages/chatbot/chabot_cli.dart';
import 'package:farmacia/pages/config/config_page.dart';
import 'package:flutter/material.dart';

//paginas
import 'package:farmacia/pages/welcome_page.dart';
import 'package:farmacia/pages/login_page.dart';
import 'package:farmacia/pages/productos/lista_productos.dart';
import 'package:farmacia/pages/usuarios/lista_usuarios.dart';
import 'package:farmacia/pages/usuarios/registro_page.dart';
import 'package:farmacia/pages/productos/nuevo_producto.dart';
import 'package:farmacia/pages/categorias/nueva_categoria.dart';
import 'package:farmacia/pages/categorias/lista_categoria.dart';
import 'package:farmacia/pages/productosCliente/lista_productos_cli.dart';
import 'package:farmacia/pages/categoriasCliente/lista_categoria_cli.dart';
import 'package:farmacia/pages/carro/detalle_carro.dart';
import 'package:farmacia/pages/perfilCliente/perfil_cliente.dart';
import 'package:farmacia/pages/config/config_page_cli.dart';

final routes = <String, WidgetBuilder>{
  'welcome': (BuildContext context) => const WelcomePage(),
  'login': (BuildContext context) => LoginPage(),
  'registro': (BuildContext context) => const RegistroPage(),
  'lista_usuarios': (BuildContext context) => const ListaUsuarios(),
  'lista_productos': (BuildContext context) => const ListaProductos(),
  'lista_categorias': (BuildContext context) => const ListaCategorias(),
  'lista_productos_cli': (BuildContext context) => const ListaProductosCli(),
  'lista_categorias_cli': (BuildContext context) => const ListaCategoriasCli(),
  'nuevo_producto': (BuildContext context) => const NuevoProducto(),
  'nueva_categoria': (BuildContext context) => const NuevaCategoria(),
  'carrito': (BuildContext context) => const DetalleCarro(),
  'perfil': (BuildContext context) => const PerfilClientePage(),
  'config': (BuildContext context) => const ConfigPage(),
  'config_cli': (BuildContext context) => const ConfigPageCli(),
  'chatbot_cli': (BuildContext context) => const ChatBotScreen()
};

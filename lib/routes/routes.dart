import 'package:flutter/material.dart';

//paginas
import 'package:farmacia/pages/welcome_page.dart';
import 'package:farmacia/pages/login_page.dart';
// import 'package:farmacia/pages/productos/lista_productos.dart';
import 'package:farmacia/pages/usuarios/lista_usuarios.dart';
import 'package:farmacia/pages/usuarios/registro_page.dart';
import 'package:farmacia/pages/productos/nuevo_producto.dart';
// import 'package:farmacia/pages/categorias/nueva_categoria.dart';
import 'package:farmacia/pages/categorias/lista_categoria.dart';
import 'package:farmacia/pages/productosCliente/lista_productos_cli.dart';
// import 'package:farmacia/pages/categoriasCliente/lista_categoria_cli.dart';
import 'package:farmacia/pages/carro/detalle_carro.dart';

final routes = <String, WidgetBuilder>{
  'welcome': (BuildContext context) => WelcomePage(),
  'login': (BuildContext context) => LoginPage(),
  'registro': (BuildContext context) => RegistroPage(),
  'lista_usuarios': (BuildContext context) => ListaUsuarios(),
  // 'lista_productos': (BuildContext context) => ListaProductos(),
  'lista_productos_cli': (BuildContext context) => ListaProductosCli(),
  'lista_categorias': (BuildContext context) => ListaCategorias(),
  // 'lista_categorias_cli': (BuildContext context) => ListaCategoriasCli(),
  'nuevo_producto': (BuildContext context) => NuevoProducto(),
  // 'nueva_categoria': (BuildContext context) => NuevaCategoria(),
  'carrito': (BuildContext context) => DetalleCarro(),
};

import 'package:flutter/material.dart';

//paginas
///import 'package:restaurante/pages/welcome_page.dart';
///import 'package:restaurante/pages/login_page.dart';
///import 'package:restaurante/pages/productos/lista_productos.dart';
///import 'package:restaurante/pages/usuarios/lista_usuarios.dart';
//import 'package:restaurante/pages/usuarios/registro_page.dart';
//import 'package:restaurante/pages/productos/nuevo_producto.dart';
///import 'package:restaurante/pages/categorias/nueva_categoria.dart';
//import 'package:restaurante/pages/categorias/lista_categoria.dart';
///import 'package:restaurante/pages/productosCliente/lista_productos_cli.dart';
//import 'package:restaurante/pages/categoriasCliente/lista_categoria_cli.dart';
///import 'package:restaurante/pages/carro/detalle_carro.dart';


final routes = <String, WidgetBuilder>{
  'welcome': (BuildContext context) => WelcomePage(),
  'login': (BuildContext context) => LoginPage(),
  'registro': (BuildContext context) => RegistroPage(),
  'lista_usuarios': (BuildContext context) => ListaUsuarios(),
  'lista_productos': (BuildContext context) => ListaProductos(),
  'lista_productos_cli': (BuildContext context) => ListaProductosCli(),
  'lista_categorias': (BuildContext context) => ListaCategorias(),
  'lista_categorias_cli': (BuildContext context) => ListaCategoriasCli(),
  'nuevo_producto' : (BuildContext context) => NuevoProducto(),
  'nueva_categoria' : (BuildContext context) => NuevaCategoria(),
  'carrito' : (BuildContext context) => DetalleCarro(),

};


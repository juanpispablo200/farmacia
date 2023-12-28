///import 'package:mongo_dart/mongo_dart.dart';
//import 'package:/modelos/productos.dart';
//import 'package:restaurante/modelos/usuarios.dart';
///import 'package:restaurante/modelos/categorias.dart';
//import 'package:restaurante/modelos/carro.dart';
//import 'package:restaurante/utilitarios/constantes.dart';

class MongoDB {
  static var db,
      collectionUsuarios,
      collectionCategorias,
      collectionProductos,
      collectionCarro;

  static conectar() async {
    db = await Db.create(CONEXION);
    print(db);
    await db.open();
    print(db);
    // sdignar las consultas que se consume a la coleccion creada
    collectionUsuarios = db.collection(COLECCION);
    collectionProductos = db.collection(COLECCION_P);
    collectionCategorias = db.collection(COLECCION_C);
    collectionCarro = db.collection(COLECCION_CAR);
  }

//GET
  static Future<List<Map<String, dynamic>>> getUsuarios() async {
    try {
      final usuarios = await collectionUsuarios.find().toList();
      return usuarios;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future<List<Map<String, dynamic>>> getProductos() async {
    try {
      final productos = await collectionProductos.find().toList();
      return productos;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future<List<Map<String, dynamic>>> getCategorias() async {
    try {
      final categorias = await collectionCategorias.find().toList();
      return categorias;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future<List<String>> getCategoriasNombres() async {
    List<String> soloNombres = [];

    try {
      final categorias = await collectionCategorias.find().toList();
      for (var categoria in categorias) {
        soloNombres.add(categoria.nombre);
      }
      return soloNombres;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future<List<Map<String, dynamic>>> getCarro() async {
    try {
      final carro = await collectionCarro.find().toList();
      return carro;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  //USUARIOS

  static insertar(Usuario usuario) async {
    await collectionUsuarios.insertAll([usuario.toMap()]);
  }

  static actualizar(Usuario usuario) async {
    var j = await collectionUsuarios.findOne({'_id': usuario.id});
    j["nombres"] = usuario.nombres;
    j["apellidos"] = usuario.apellidos;
    j["cedula"] = usuario.cedula;
    j["telefono"] = usuario.telefono;
    j["correo"] = usuario.correo;
    j["password"] = usuario.password;
    j["carrera"] = usuario.carrera;
    await collectionUsuarios.save(j);
  }

  static eliminar(Usuario usuario) async {
    await collectionUsuarios.remove(where.id(usuario.id));
  }

  //PRODUCTOS
  static insertarP(Producto producto) async {
    await collectionProductos.insertAll([producto.toMap()]);
  }

  static actualizarP(Producto producto) async {
    var j = await collectionProductos.findOne({'_id': producto.id});
    j["nombre"] = producto.nombre;
    j["descripcion"] = producto.descripcion;
    j["cantidad"] = producto.cantidad;
    j["categoria"] = producto.categoria;
    j["img"] = producto.img;
    j["precio"] = producto.precio;
    j["stock"] = producto.stock;
    await collectionProductos.save(j);
  }

  static eliminarP(Producto producto) async {
    await collectionProductos.remove(where.id(producto.id));
  }

  //CATEGORIAS
  static insertarC(Categoria categoria) async {
    await collectionCategorias.insertAll([categoria.toMap()]);
  }

  static actualizarC(Categoria categoria) async {
    var j = await collectionCategorias.findOne({'_id': categoria.id});
    j["nombre"] = categoria.nombre;
    j["descripcion"] = categoria.descripcion;
    await collectionCategorias.save(j);
  }

  static eliminarC(Categoria categoria) async {
    await collectionCategorias.remove(where.id(categoria.id));
  }

  //CARRITO
  static insertarCr(Carro carro) async {
    await collectionCarro.insertAll([carro.toMap()]);
  }

  static actualizarCr(Carro carro) async {
    var j = await collectionCarro.findOne({'_id': carro.id});
    j["usuario_id"] = carro.usuario_id;
    j["producto_ids"] = carro.producto_ids;
    await collectionCarro.save(j);
  }

  static eliminarCr(Carro carro) async {
    await collectionCarro.remove(where.id(carro.id));
  }

  // agregar el metodo de autentificacion usuarios
  static Future<Map<String, dynamic>> autenticarUsuarios(
      String email, String password) async {
    try {
      final usuario =
          await collectionUsuarios.findOne(where.eq('correo', email));
      if (usuario != null && usuario['password'] == password) {
        return {
          'exito': true,
          'rol': usuario['rol'],
        };
      } else {
        return {
          'exito': false,
        };
      }
    } catch (e) {
      print(e);
      return {
        'exito': false,
      };
    }
  }
}

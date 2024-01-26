import 'package:mongo_dart/mongo_dart.dart';

import 'package:farmacia/modelos/carro.dart';
import 'package:farmacia/modelos/usuarios.dart';
import 'package:farmacia/modelos/productos.dart';
import 'package:farmacia/modelos/categorias.dart';
import 'package:farmacia/utilitarios/logger.dart';
import 'package:farmacia/utilitarios/constantes.dart';

class MongoDB {
  static Db? db;
  static late DbCollection collectionUsuarios;
  static late DbCollection collectionCategorias;
  static late DbCollection collectionProductos;
  static late DbCollection collectionCarro;

  static Future<void> conectar() async {
    Db db = await Db.create(testConexion);
    logger.i("Intentando conectar a la base de datos");
    await db.open();
    if (db.state == State.open) {
      logger.i("Conectado a la base de datos: ${db.databaseName ?? "null"}");
    } else {
      logger.e(
          "No se pudo conectar a la base de datos: ${db.databaseName ?? "null"}");
    }
    // asignar las consultas que se consume a la coleccion creada
    collectionUsuarios = db.collection(collecion);
    collectionProductos = db.collection(collecionP);
    collectionCategorias = db.collection(collecionC);
    collectionCarro = db.collection(collecionCar);
  }

//GET
  static Future<List<Map<String, dynamic>>> getUsuarios() async {
    try {
      final usuarios = await collectionUsuarios.find().toList();
      return usuarios;
    } catch (e) {
      logger.e("Error al obtener usuarios");
      return Future.value([]);
    }
  }

  static Future<Usuario?> getUsuarioPorId(String userId) async {
    try {
      final usuarioMap =
          await collectionUsuarios.findOne(where.id(ObjectId.parse(userId)));
      if (usuarioMap != null) {
        return Usuario.fromMap(usuarioMap);
      }
    } catch (e) {
      logger.e("Error al obtener usuario por ID $e");
    }
    return null;
  }

  static Future<List<Map<String, dynamic>>> getProductos() async {
    try {
      final productos = await collectionProductos.find().toList();
      return productos;
    } catch (e) {
      logger.e("Error al obtener productos");
      return Future.value([]);
    }
  }

  static Future<Producto?> getProductoPorId(String productId) async {
    try {
      final productoMap = await collectionProductos.findOne(
        where.id(
          ObjectId.parse(productId),
        ),
      );
      if (productoMap != null) {
        return Producto.fromMap(productoMap);
      }
    } catch (e) {
      logger.e("Error al obtener productos");
    }
    return null;
  }

  static Future<List<Map<String, dynamic>>> getCategorias() async {
    try {
      final categorias = await collectionCategorias.find().toList();
      return categorias;
    } catch (e) {
      logger.e("Error al obtener categorias");
      return Future.value([]);
    }
  }

  static Future<List<String>> getCategoriasNombres() async {
    List<String> soloNombres = [];

    try {
      final categorias = await collectionCategorias.find().toList();
      for (var categoria in categorias) {
        soloNombres.add(categoria['nombre']);
      }
      return soloNombres;
    } catch (e) {
      logger.e("Error al obtener Nombre de Categorias");
      return Future.value([]);
    }
  }

  static Future<List<Map<String, dynamic>>> getCarro() async {
    try {
      final carro = await collectionCarro.find().toList();
      return carro;
    } catch (e) {
      logger.e("Error al obtener carro");
      return Future.value([]);
    }
  }

  static Future<List<Map<String, dynamic>>> getCarroPorUsuario(
      String usuarioId) async {
    try {
      final carro = await collectionCarro
          .find(
            where.eq('usuarioId', ObjectId.parse(usuarioId)),
          )
          .toList();
      return carro;
    } catch (e) {
      logger.e("Error al obtener carro");
      return Future.value([]);
    }
  }

  static Future<List<Map<String, dynamic>>> getProductosPorCategoria(
      Categoria categoria) async {
    try {
      final productos = await collectionProductos
          .find({'categoria': categoria.nombre}).toList();

      return productos;
    } catch (e) {
      logger.e("Error al obtener carro");
      return Future.value([]);
    }
  }

  //USUARIOS

  static insertar(Usuario usuario) async {
    await collectionUsuarios.insertAll([usuario.toMap()]);
  }

  static actualizar(Usuario usuario) async {
    var j = await collectionUsuarios.findOne({'_id': usuario.id});
    if (j != null) {
      j["nombres"] = usuario.nombres;
      j["apellidos"] = usuario.apellidos;
      j["cedula"] = usuario.cedula;
      j["telefono"] = usuario.telefono;
      j["correo"] = usuario.correo;
      j["password"] = usuario.password;
      j["carrera"] = usuario.carrera;
      await collectionUsuarios.replaceOne({'_id': usuario.id}, j);
    } else {
      logger.e("Error al actualizar usuario");
    }
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
    if (j != null) {
      j["nombre"] = producto.nombre;
      j["descripcion"] = producto.descripcion;
      j["cantidad"] = producto.cantidad;
      j["categoria"] = producto.categoria;
      j["img"] = producto.img;
      j["precio"] = producto.precio;
      j["stock"] = producto.stock;
      await collectionProductos.replaceOne({'_id': producto.id}, j);
    } else {
      logger.e("Error al actualizar producto");
    }
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
    if (j != null) {
      j["nombre"] = categoria.nombre;
      j["descripcion"] = categoria.descripcion;
      await collectionCategorias.replaceOne({'_id': categoria.id}, j);
    }
  }

  static eliminarC(Categoria categoria) async {
    await collectionCategorias.remove(where.id(categoria.id));
  }

  //CARRITO
  static insertarCr(Carro carro) async {
    await collectionCarro.insertAll([carro.toMap()]);
  }

  static insertarProdCr(String usuarioId, Producto producto) async {
    var j =
        await collectionCarro.findOne({'usuarioId': ObjectId.parse(usuarioId)});
    if (j != null) {
      if (j["productoIds"] == null) {
        j["productoIds"] = [];
      }
      j["productoIds"].add(producto.id);
      await collectionCarro
          .replaceOne({'usuarioId': ObjectId.parse(usuarioId).toString()}, j);
    }
  }

  static actualizarCr(Carro carro) async {
    var j = await collectionCarro.findOne({'_id': carro.id});
    if (j != null) {
      j["usuario_id"] = carro.usuarioId;
      j["producto_ids"] = carro.productoIds;
      await collectionCarro.replaceOne({'_id': carro.id}, j);
    }
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
          '_id': usuario['_id'].toString(),
          'rol': usuario['rol'],
        };
      } else {
        return {
          'exito': false,
        };
      }
    } catch (e) {
      logger.e("Error al autenticar usuarios");
      return {
        'exito': false,
      };
    }
  }
}

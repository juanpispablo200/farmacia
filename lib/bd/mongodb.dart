import 'package:mongo_dart/mongo_dart.dart';

import 'package:farmacia/modelos/carro.dart';
import 'package:farmacia/modelos/usuarios.dart';
import 'package:farmacia/modelos/productos.dart';
import 'package:farmacia/modelos/categorias.dart';
import 'package:farmacia/utilitarios/logger.dart';
import 'package:farmacia/utilitarios/constantes.dart';

class MongoDB {
  static Db? db;
  static late DbCollection collectionUsuarios,
      collectionProductos,
      collectionCategorias,
      collectionCarro;

  static Future<void> conectar() async {
    Db db = await Db.create(conexion);
    logger.i("Intentando conectar a la base de datos");
    await db.open();
    if (db.state == State.open) {
      logger.i("Conectado a la base de datos: ${db.databaseName ?? "null"}");
    } else {
      logger.e(
          "No se pudo conectar a la base de datos: ${db.databaseName ?? "null"}");
    }
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
      logger.e("Error al obtener todos los productos $e");
      return Future.value([]);
    }
  }

  static Future<Producto?> getProductoPorId(String productId) async {
    try {
      final productoMap = await collectionProductos.findOne(
        where.id(
          ObjectId.parse(productId.substring(10, 34)),
        ),
      );
      if (productoMap != null) {
        return Producto.fromMap(productoMap);
      }
    } catch (e) {
      logger.e("Error al obtener producto por id $e");
    }
    return null;
  }

  static Future<List<Producto>> getProductosPorCarro(
      Map<String, int> productos) async {
    try {
      final productoIds = productos.keys.toList();
      final productosMaps = await collectionProductos
          .find(
            where.oneFrom(
              '_id',
              productoIds
                  .map((id) => ObjectId.parse(id.substring(10, 34)))
                  .toList(),
            ),
          )
          .toList();

      return productosMaps
          .map((productoMap) => Producto.fromMap(productoMap))
          .toList();
    } catch (e) {
      logger.e("Error al obtener productos por carro");
      return Future.value([]);
    }
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

  static Future<Categoria?> getCategoriaPorId(String categoryId) async {
    try {
      final categoriaMap = await collectionCategorias.findOne(
        where.id(
          ObjectId.parse(categoryId.substring(10, 34)),
        ),
      );
      if (categoriaMap != null) {
        return Categoria.fromMap(categoriaMap);
      }
    } catch (e) {
      logger.e("Error al obtener categoria por id $e");
    }
    return null;
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

  static Future<Map<String, dynamic>?> getCarroPorUsuario(
      String usuarioId) async {
    try {
      final carro = await collectionCarro.findOne(
        where.eq('usuarioId', ObjectId.parse(usuarioId)),
      );
      return carro;
    } catch (e) {
      logger.e("Error al obtener carro");
      return Future.value(null);
    }
  }

  static Future<int> getPrecioTotalCarro(Map<String, int> productos) async {
    try {
      final productoIds = productos.keys.toList();
      final productosMaps = await collectionProductos
          .find(
            where.oneFrom(
              '_id',
              productoIds
                  .map((id) => ObjectId.parse(id.substring(10, 34)))
                  .toList(),
            ),
          )
          .toList();

      final precioTotal = productosMaps.fold<int>(0, (prev, prod) {
        final cantidad = productos[prod['_id'].toString()]!;
        return (prev + (prod['precio'] * cantidad)).toInt();
      });

      return precioTotal;
    } catch (e) {
      logger.e("Error al obtener precio total del carro");
      return Future.value(0);
    }
  }

  static Future<List<Map<String, dynamic>>> getProductosPorCategoria(
      Categoria categoria) async {
    try {
      var productos = await collectionProductos
          .find(where.eq('categoria', categoria.id.toString()))
          .toList();

      return productos;
    } catch (e) {
      logger.e("Error al obtener productos por categoria");
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
      if (j["productos"] == null) {
        j["productos"] = {};
      }
      j["productos"][producto.id.toString()] = 1;
      collectionCarro.replaceOne({'usuarioId': ObjectId.parse(usuarioId)}, j);
    } else {
      logger.e("Error al insertar producto en carro");
    }
  }

  static removerProdCr(String usuarioId, String productoId) async {
    var j =
        await collectionCarro.findOne({'usuarioId': ObjectId.parse(usuarioId)});
    if (j != null) {
      if (j["productos"] != null && j["productos"][productoId] != null) {
        j["productos"].remove(productoId);
        await collectionCarro
            .replaceOne({'usuarioId': ObjectId.parse(usuarioId)}, j);
      } else {
        logger.e("Error: Producto not found in carro");
      }
    } else {
      logger.e("Error: Carro not found for the given usuarioId");
    }
  }

  static actualizarCr(Carro carro) async {
    var j = await collectionCarro.findOne({'_id': carro.id});
    if (j != null) {
      j["producto_ids"] = carro.productos;
      await collectionCarro.replaceOne({'_id': carro.id}, j);
    }
  }

  static actualizarCantidadCr(
      String usuarioId, String productoId, int cantidad) async {
    var j =
        await collectionCarro.findOne({'usuarioId': ObjectId.parse(usuarioId)});
    if (j != null) {
      if (j["productos"] != null && j["productos"][productoId] != null) {
        j["productos"][productoId] = cantidad;
        await collectionCarro
            .replaceOne({'usuarioId': ObjectId.parse(usuarioId)}, j);
      } else {
        logger.e("Error: Producto not found in carro");
      }
    } else {
      logger.e("Error: Carro not found for the given usuarioId");
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

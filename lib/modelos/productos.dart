import 'package:mongo_dart/mongo_dart.dart';

class Producto {
  final ObjectId id;
  final String nombre;
  final String descripcion;
  final String categoria;
  final String img;
  final double precio;
  final String stock;

  const Producto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.categoria,
    required this.img,
    required this.precio,
    required this.stock,
  });
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'categoria': categoria,
      'img': img,
      'precio': precio,
      'stock': stock,
    };
  }

  Producto.fromMap(Map<String, dynamic> map)
      : nombre = map['nombre'],
        id = map['_id'],
        descripcion = map['descripcion'],
        categoria = map['categoria'],
        img = map['img'],
        precio = double.parse(map['precio']),
        stock = map['stock'];
}

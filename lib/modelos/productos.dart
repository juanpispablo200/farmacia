import 'package:mongo_dart/mongo_dart.dart';

class Producto {
  final ObjectId id;
  final String nombre, descripcion, categoria, img;
  final double precio;
  final int stock;

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
        precio = map['precio'] is int
            ? (map['precio'] as int).toDouble()
            : map['precio'],
        stock = map['stock'];
}

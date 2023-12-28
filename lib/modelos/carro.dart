import 'package:mongo_dart/mongo_dart.dart';
import 'package:farmacia/modelos/productos.dart';

class Carro {
  final ObjectId id;
  final ObjectId usuarioId;
  final List<Producto> productoIds;
  final double valorTotal;

  const Carro({
    required this.id,
    required this.usuarioId,
    required this.productoIds,
    required this.valorTotal,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'usuarioId': usuarioId,
      'productoIds': productoIds.map((p) => p.toMap()).toList(),
      'valorTotal': valorTotal,
    };
  }

  Carro.fromMap(Map<String, dynamic> map)
      : usuarioId = map['usuarioId'],
        id = map['_id'],
        productoIds = List<Producto>.from(
          map['productoIds'].map((p) => Producto.fromMap(p)),
        ),
        valorTotal = double.parse(map['valorTotal'].toString());
}

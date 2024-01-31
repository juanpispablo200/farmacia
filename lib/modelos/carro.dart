import 'package:mongo_dart/mongo_dart.dart';

class Carro {
  final ObjectId id;
  final ObjectId usuarioId;
  final Map<String, int> productos;

  const Carro({
    required this.id,
    required this.usuarioId,
    required this.productos,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'usuarioId': usuarioId,
      'productos': productos,
    };
  }

  Carro.fromMap(Map<String, dynamic> map)
      : usuarioId = map['usuarioId'],
        id = map['_id'],
        productos = (map['productos'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, value as int));
}

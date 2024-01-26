import 'package:mongo_dart/mongo_dart.dart';

class Carro {
  final ObjectId id;
  final ObjectId usuarioId;
  final List<String> productoIds;

  const Carro({
    required this.id,
    required this.usuarioId,
    required this.productoIds,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'usuarioId': usuarioId,
      'productoIds': productoIds,
    };
  }

  Carro.fromMap(Map<String, dynamic> map)
      : usuarioId = map['usuarioId'],
        id = map['_id'],
        productoIds =
            List<String>.from(map['productoIds'].map((id) => id.toString()));
}

//import 'package:mongo_dart/mongo_dart.dart';

class Categoria {
  final ObjectId id;
  final String nombre;
  final String descripcion;

  const Categoria ({
    required this.id,
    required this.nombre,
    required this.descripcion,

  });

  Map <String, dynamic> toMap(){
    return{
      '_id': id,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }

  Categoria.fromMap(Map<String, dynamic> map)
      :nombre = map['nombre'],
        id = map['_id'],
        descripcion = map['descripcion'];

}
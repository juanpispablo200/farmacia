import 'package:mongo_dart/mongo_dart.dart';

class Usuario {
  final ObjectId id;
  final String nombres;
  final String apellidos;
  final String correo;
  final String password;
  final String cedula;
  final String telefono;
  final String carrera;
  final String rol;

  const Usuario({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.cedula,
    required this.correo,
    required this.password,
    required this.telefono,
    required this.carrera,
    required this.rol,
  });
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'nombres': nombres,
      'apellidos': apellidos,
      'cedula': cedula,
      'telefono': telefono,
      'correo': correo,
      'password': password,
      'carrera': carrera,
      'rol': rol,
    };
  }

  Usuario.fromMap(Map<String, dynamic> map)
      : nombres = map['nombres'],
        id = map['_id'],
        apellidos = map['apellidos'],
        cedula = map['cedula'],
        telefono = map['telefono'],
        correo = map['correo'],
        password = map['password'],
        carrera = map['carrera'],
        rol = map['rol'];
}

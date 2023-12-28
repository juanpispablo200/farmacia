//import 'package:mongo_dart/mongo_dart.dart';
//import 'package:farmacia/modelos/productos.dart';

class Carro {
  final ObjectId id;
  final ObjectId usuario_id;
  final List<Producto> producto_ids;
  final double valor_total;

  const Carro({
    required this.id,
    required this.usuario_id,
    required this.producto_ids,
    required this.valor_total,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'usuario_id': usuario_id,
      'producto_ids': producto_ids.map((p) => p.toMap()).toList(),
      'valor_total': valor_total,
    };
  }

  Carro.fromMap(Map<String, dynamic> map)
      : usuario_id = map['usuario_id'],
        id = map['_id'],
        producto_ids = List<Producto>.from(
          map['producto_ids'].map((p) => Producto.fromMap(p)),
        ),
        valor_total = double.parse(map['valor_total'].toString());
}

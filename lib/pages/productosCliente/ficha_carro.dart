import 'package:flutter/material.dart';
import 'package:farmacia/modelos/productos.dart';
import 'package:farmacia/modelos/carro.dart';
import 'package:farmacia/modelos/usuarios.dart';

class FichaCarro extends StatelessWidget {
  final Producto producto;
  final Usuario usuario;
  final Carro carrito;

  FichaCarro({
    required this.usuario,
    required this.carrito,
    required this.producto,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

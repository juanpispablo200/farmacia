import 'package:flutter/material.dart';
import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/categorias.dart';

class ProductDropdown extends StatefulWidget {
  final Categoria categoria;

  const ProductDropdown({super.key, required this.categoria});

  @override
  ProductDropdownState createState() => ProductDropdownState();
}

class ProductDropdownState extends State<ProductDropdown> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: MongoDB.getProductosPorCategoria(widget.categoria),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return SizedBox(
            height: 50,
            width: 200,
            child: Material(
              child: DropdownButton<String>(
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: snapshot.data!.map<DropdownMenuItem<String>>(
                    (Map<String, dynamic> product) {
                  return DropdownMenuItem<String>(
                    value: product['nombre'],
                    child: Text(product['nombre']),
                  );
                }).toList(),
              ),
            ),
          );
        }
      },
    );
  }
}

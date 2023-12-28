import 'package:restaurante/modelos/carro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FichaCarro extends StatelessWidget {

  final Carro carro;
  final VoidCallback onTapDelete;

  FichaCarro({
    required this.onTapDelete, required this.carro,
  }
      );
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      color: Colors.amberAccent,
      child: ListTile(
        leading: Text('${carro.producto_ids}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        //subtitle: Text(categoria.),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              child: Icon(Icons.delete),
              onTap: onTapDelete,
            )
          ],
        ),
      ),
    );
  }
}
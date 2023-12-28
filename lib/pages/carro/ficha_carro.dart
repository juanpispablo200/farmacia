import 'package:farmacia/modelos/carro.dart';
import 'package:flutter/material.dart';

class FichaCarro extends StatelessWidget {
  final Carro carro;
  final VoidCallback onTapDelete;

  const FichaCarro({
    super.key,
    required this.onTapDelete,
    required this.carro,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      color: Colors.amberAccent,
      child: ListTile(
        leading: Text(
          '${carro.productoIds}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        //subtitle: Text(categoria.),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: onTapDelete,
              child: const Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }
}

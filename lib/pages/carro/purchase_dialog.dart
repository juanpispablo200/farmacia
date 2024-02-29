import 'package:flutter/material.dart';

class PurchaseDialog extends StatefulWidget {
  const PurchaseDialog({super.key});

  @override
  PurchaseDialogState createState() => PurchaseDialogState();
}

class PurchaseDialogState extends State<PurchaseDialog> {
  bool _purchaseConfirmed = false;

  void _confirmPurchase() {
    setState(() {
      _purchaseConfirmed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(_purchaseConfirmed ? 'Compra Confirmada' : 'Confirmar Compra'),
      content: Text(_purchaseConfirmed
          ? 'Compra realizada con éxito'
          : '¿Está seguro de realizar esta compra?'),
      actions: <Widget>[
        if (!_purchaseConfirmed)
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        TextButton(
          onPressed: _purchaseConfirmed
              ? () {
                  Navigator.of(context).pop();
                }
              : _confirmPurchase,
          child: Text(_purchaseConfirmed ? 'Ok' : 'Confirmar'),
        ),
      ],
    );
  }
}

import 'package:farmacia/widgets/menu_cliente.dart';
import 'package:flutter/material.dart';

class AppBarCli extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showMenu;

  const AppBarCli({
    Key? key,
    required this.title,
    this.showMenu = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: showMenu ? [menuCliente(context)] : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';

import 'package:farmacia/widgets/menu_admin.dart';

class AppBarAdmin extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showMenu;

  const AppBarAdmin({Key? key, required this.title, this.showMenu = true})
      : super(key: key);

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
      actions: showMenu ? [menuAdmin(context)] : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

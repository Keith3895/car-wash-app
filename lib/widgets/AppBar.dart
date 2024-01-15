import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String AppBarText;
  const CustomAppBar(this.AppBarText, {super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      title: Center(
          child: Text(
        AppBarText,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      )),
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

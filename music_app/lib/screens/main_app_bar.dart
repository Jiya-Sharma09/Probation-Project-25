import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onSettingsTap;
  final Color? color;

  const MainAppBar({
    super.key,
    required this.title,
    required this.onSettingsTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: color ?? const Color(0xFF7A43BF),
      centerTitle: true,

      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),

      actions: [
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: onSettingsTap,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}

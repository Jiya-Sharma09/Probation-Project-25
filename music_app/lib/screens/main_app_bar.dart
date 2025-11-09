import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onSettingsTap;

  const MainAppBar({
    super.key,
    required this.title,
    required this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,

      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF512D80),
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),

      actions: [
        IconButton(
          icon: const Icon(
            Icons.settings,
            color: Color(0xFF512D80),
          ),
          onPressed: onSettingsTap,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}

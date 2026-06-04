import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.color,
  });
  final String title;
  final VoidCallback onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,

      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    );
  }
}

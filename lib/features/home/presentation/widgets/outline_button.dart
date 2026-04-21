import 'package:flutter/material.dart';

class OutlineButton extends StatelessWidget {
  const OutlineButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
    required this.borderColor,
    required this.textColor,
    required this.iconColor,
    required this.backgroundColor,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String text;
  final Color borderColor;
  final Color textColor;
  final Color iconColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          foregroundColor: textColor,
          side: BorderSide(color: borderColor, width: 1.4),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        onPressed: onPressed,
        icon: Icon(icon, color: iconColor),
        label: Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: textColor),
        ),
      ),
    );
  }
}

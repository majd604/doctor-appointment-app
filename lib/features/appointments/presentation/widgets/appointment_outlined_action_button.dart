// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

class AppointmentOutlinedActionButton extends StatelessWidget {
  const AppointmentOutlinedActionButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.red.withOpacity(0.12),
        foregroundColor: Colors.red,
        side: BorderSide(color: Colors.red),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}

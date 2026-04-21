import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextAuthLogOrSign extends StatelessWidget {
  const TextAuthLogOrSign({super.key, required this.text1, required this.text2, this.onTap});
  final String text1;
  final String text2;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text1,
        style: const TextStyle(color: Colors.grey, fontSize: 15),
        children: [
          TextSpan(
            text: text2,
            style: const TextStyle(color: Color(0xFF0B7A75), fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}

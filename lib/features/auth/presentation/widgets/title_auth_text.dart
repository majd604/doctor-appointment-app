import 'package:flutter/material.dart';

class TitleAuthText extends StatelessWidget {
  const TitleAuthText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
      textAlign: TextAlign.center,
    );
  }
}

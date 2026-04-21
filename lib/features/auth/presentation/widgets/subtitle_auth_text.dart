import 'package:flutter/material.dart';

class SubtitleAuthText extends StatelessWidget {
  const SubtitleAuthText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, color: Colors.grey),
      textAlign: TextAlign.center,
    );
  }
}

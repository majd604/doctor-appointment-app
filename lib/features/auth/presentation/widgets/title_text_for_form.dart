import 'package:flutter/material.dart';

class TitleTextForForm extends StatelessWidget {
  const TitleTextForForm({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500),
      ),
    );
  }
}

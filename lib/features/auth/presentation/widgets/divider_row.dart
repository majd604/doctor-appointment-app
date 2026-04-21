import 'package:flutter/material.dart';

class DividerRow extends StatelessWidget {
  const DividerRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 1.2, color: Colors.grey.shade300)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text("Or Continue with", style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
        ),
        Expanded(child: Divider(thickness: 1.2, color: Colors.grey.shade300)),
      ],
    );
  }
}

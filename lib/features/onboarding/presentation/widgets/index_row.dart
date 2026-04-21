// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class IndexRow extends StatelessWidget {
  const IndexRow({super.key, required this.currentPage});

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final bool isActive = currentPage == index;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 22 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF0B7A75) : Colors.white.withOpacity(0.45),
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DateSelectorCard extends StatelessWidget {
  const DateSelectorCard({super.key, required this.displayText, required this.onTap, required this.isSelected});

  final String displayText;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_month_rounded, color: AppColors.primaryColor),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                displayText,
                style: TextStyle(
                  fontSize: 15,
                  color: isSelected ? const Color(0xFF1F2937) : const Color(0xFF7C8796),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Color(0xFF7C8796)),
          ],
        ),
      ),
    );
  }
}

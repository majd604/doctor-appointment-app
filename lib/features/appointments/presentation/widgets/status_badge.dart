// ignore_for_file: deprecated_member_use

import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final statusLower = status.toLowerCase();

    Color bgColor;
    Color textColor;

    if (statusLower == "pending") {
      bgColor = Colors.orange.withOpacity(0.12);
      textColor = Colors.orange;
    } else if (statusLower == "completed") {
      bgColor = Colors.green.withOpacity(0.12);
      textColor = Colors.green;
    } else if (statusLower == "cancelled") {
      bgColor = Colors.red.withOpacity(0.12);
      textColor = Colors.red;
    } else {
      bgColor = AppColors.primaryColor.withOpacity(0.10);
      textColor = AppColors.primaryColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(14)),
      child: Text(
        status,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: textColor),
      ),
    );
  }
}

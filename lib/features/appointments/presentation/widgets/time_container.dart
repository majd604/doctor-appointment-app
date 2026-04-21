import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TimeContainer extends StatelessWidget {
  const TimeContainer({super.key, required this.time, required this.icon});
  final String time;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: AppColors.cardBg, borderRadius: BorderRadius.circular(12)),
      child: Row(
        spacing: 8,
        children: [
          Icon(icon, color: AppColors.primaryColor),
          Text(
            time,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}

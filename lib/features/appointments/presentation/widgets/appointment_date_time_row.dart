import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppointmentDateTimeRow extends StatelessWidget {
  const AppointmentDateTimeRow({super.key, required this.dateText, required this.timeText});

  final String dateText;
  final String timeText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(18)),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                const Icon(Icons.calendar_month_rounded, size: 18, color: AppColors.primaryColor),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    dateText,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF4B5563)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                const Icon(Icons.access_time_rounded, size: 18, color: AppColors.primaryColor),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    timeText,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF4B5563)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

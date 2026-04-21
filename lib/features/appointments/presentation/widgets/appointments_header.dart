// ignore_for_file: unused_element, deprecated_member_use

import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppointmentsHeader extends StatelessWidget {
  const AppointmentsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 14, offset: const Offset(0, 5))],
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xFFE8F7F6),
            child: Icon(Icons.calendar_month_rounded, color: AppColors.primaryColor),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "Manage your upcoming appointments",
              style: TextStyle(fontSize: 15, color: Color(0xFF6B7280), fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class BuildBanner extends StatelessWidget {
  const BuildBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0B7A75), Color(0xFF149C95)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(color: AppColors.primaryColor.withOpacity(0.25), blurRadius: 18, offset: const Offset(0, 10)),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.18), borderRadius: BorderRadius.circular(18)),
            child: const Icon(Icons.health_and_safety_outlined, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Feeling Unwell?",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: Colors.white),
                ),
                SizedBox(height: 6),
                Text(
                  "Book an appointment with a doctor quickly and easily.",
                  style: TextStyle(fontSize: 13.5, height: 1.35, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

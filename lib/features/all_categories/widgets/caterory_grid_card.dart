// ignore_for_file: deprecated_member_use

import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:doctor_appointment_app/core/utils/icon_mapper.dart';
import 'package:flutter/material.dart';

class CategoryGridCard extends StatelessWidget {
  const CategoryGridCard({super.key, required this.title, required this.iconName, required this.onTap});

  final String title;
  final String iconName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 62,
                width: 62,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(IconMapper.getIcon(iconName), color: AppColors.primaryColor, size: 30),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, color: Color(0xFF1F2937)),
              ),
              const SizedBox(height: 12),
              const Icon(Icons.arrow_forward_rounded, size: 18, color: Color(0xFF9CA3AF)),
            ],
          ),
        ),
      ),
    );
  }
}

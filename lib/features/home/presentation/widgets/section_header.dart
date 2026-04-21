import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, required this.onTap, this.showSeeAll = true, this.size = 22});
  final String title;
  final VoidCallback onTap;
  final bool showSeeAll;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: size, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTap,
          child: showSeeAll
              ? Text(
                  "See All",
                  style: TextStyle(fontSize: 14, color: AppColors.primaryColor, fontWeight: FontWeight.w700),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}

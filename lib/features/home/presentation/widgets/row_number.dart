import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:doctor_appointment_app/features/home/data/models/doctor_model.dart';
import 'package:flutter/material.dart';

class RowPhone extends StatelessWidget {
  const RowPhone({super.key, required this.doctor});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.phone_outlined, size: 18, color: AppColors.primaryColor),
        const SizedBox(width: 6),
        Text(
          doctor.phone!,
          style: const TextStyle(fontSize: 14, color: AppColors.primaryColor, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/screen/book_appointments_screen.dart';
import 'package:flutter/material.dart';

class DoctorInfoCardAppointments extends StatelessWidget {
  const DoctorInfoCardAppointments({super.key, required this.widget});

  final BookAppointmentsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 14, offset: const Offset(0, 5))],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(
              widget.doctor.imageUrl,
              height: 85,
              width: 85,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 85,
                  width: 85,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.person, size: 36, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.doctor.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.doctor.specialty,
                  style: const TextStyle(fontSize: 14, color: Color(0xFF7C8796), fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${widget.doctor.bookingPrice?.toStringAsFixed(0) ?? '0'} EGP',
                    style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w700, fontSize: 13),
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

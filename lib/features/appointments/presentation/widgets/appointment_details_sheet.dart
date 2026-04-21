// ignore_for_file: deprecated_member_use

import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:doctor_appointment_app/features/appointments/data/model/appointmen_model.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/widgets/doctor_image.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/widgets/info_row.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsSheet extends StatelessWidget {
  const AppointmentDetailsSheet({super.key, required this.appointment});

  final AppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    final bool isPending = appointment.status.toLowerCase() == 'pending';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 52,
                height: 5,
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(20)),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  DoctorImage(imageUrl: appointment.doctorImageUrl, height: 88, width: 88),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment.doctorName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          appointment.doctorSpecialty ?? "No Specialty",
                          style: const TextStyle(fontSize: 14, color: Color(0xFF7C8796), fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isPending
                                ? Colors.orange.withOpacity(0.12)
                                : AppColors.primaryColor.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            appointment.status,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: isPending ? Colors.orange : AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(22)),
                child: Column(
                  children: [
                    InfoRow(icon: Icons.calendar_month_rounded, title: "Date", value: _formatDate(appointment.date)),
                    const SizedBox(height: 14),
                    InfoRow(icon: Icons.access_time_rounded, title: "Time", value: appointment.time),
                    const SizedBox(height: 14),
                    InfoRow(icon: Icons.person_outline_rounded, title: "Patient", value: appointment.patientName),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 14, offset: const Offset(0, 5)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.notes_rounded, color: AppColors.primaryColor, size: 20),
                        SizedBox(width: 8),
                        Text(
                          "Appointment Notes",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      (appointment.notes != null && appointment.notes!.trim().isNotEmpty)
                          ? appointment.notes!
                          : "No additional notes were added for this appointment.",
                      style: const TextStyle(fontSize: 14.5, height: 1.6, color: Color(0xFF4B5563)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.check_circle_outline_rounded),
                  label: const Text("Done", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    return '${date.day} ${monthNames[date.month - 1]} ${date.year}';
  }
}

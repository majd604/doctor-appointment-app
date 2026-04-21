import 'package:doctor_appointment_app/features/home/data/models/doctor_model.dart';
import 'package:doctor_appointment_app/features/home/presentation/widgets/row_number.dart';
import 'package:flutter/material.dart';

class DoctorInfoCard extends StatelessWidget {
  const DoctorInfoCard({super.key, required this.doctor});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          // ignore: deprecated_member_use
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                doctor.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border, color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            doctor.specialty,
            style: const TextStyle(fontSize: 16, color: Color(0xFF7C8796), fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
              const SizedBox(width: 6),
              Text(
                doctor.rating.toString(),
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF4B5563)),
              ),
              const Spacer(),
              if (doctor.phone != null && doctor.phone!.isNotEmpty) RowPhone(doctor: doctor),
            ],
          ),
        ],
      ),
    );
  }
}

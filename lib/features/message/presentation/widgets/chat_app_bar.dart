import 'package:doctor_appointment_app/features/home/data/models/doctor_model.dart';
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({super.key, required this.doctor});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(
              doctor.imageUrl,
              height: 42,
              width: 42,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.person),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
                ),
                Text(doctor.specialty, style: const TextStyle(fontSize: 13, color: Color(0xFF7C8796))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

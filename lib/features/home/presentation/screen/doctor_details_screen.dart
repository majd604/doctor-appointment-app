// ignore_for_file: deprecated_member_use

import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/screen/book_appointments_screen.dart';
import 'package:doctor_appointment_app/features/auth/data/model/user_model.dart';
import 'package:doctor_appointment_app/features/home/data/models/doctor_model.dart';
import 'package:doctor_appointment_app/features/home/presentation/widgets/doctor_info_card.dart';
import 'package:doctor_appointment_app/features/home/presentation/widgets/outline_button.dart';
import 'package:doctor_appointment_app/features/home/presentation/widgets/price_card.dart';

import 'package:doctor_appointment_app/features/home/presentation/widgets/title_text.dart';
import 'package:doctor_appointment_app/features/message/presentation/screen/chat_screen.dart';
import 'package:flutter/material.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({super.key, required this.doctor, required this.user});

  final DoctorModel doctor;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Doctor Details"),
        centerTitle: true,
        backgroundColor: AppColors.cardBg,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Image
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                doctor.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 300,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.person, size: 80, color: Colors.grey),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Info Card
            DoctorInfoCard(doctor: doctor),

            const SizedBox(height: 24),

            // About Section
            TitleText(title: "About Doctor"),
            const SizedBox(height: 0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 14, offset: const Offset(0, 5)),
                ],
              ),
              child: Text(
                doctor.about ?? "No information available about this doctor.",
                style: const TextStyle(fontSize: 15, height: 1.6, color: Color(0xFF4B5563)),
              ),
            ),

            const SizedBox(height: 24),

            // Price Section
            TitleText(title: "Services & Prices"),
            const SizedBox(height: 14),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                PriceCard(icon: Icons.phone_in_talk_rounded, title: "Call", price: doctor.callPrice),
                PriceCard(icon: Icons.chat_bubble_outline_rounded, title: "Message", price: doctor.messagePrice),
                PriceCard(icon: Icons.calendar_month_rounded, title: "Booking", price: doctor.bookingPrice),
              ],
            ),

            const SizedBox(height: 28),

            // Action Buttons
            const SizedBox(height: 12),
            OutlineButton(
              text: "Send Message",
              icon: Icons.chat_bubble_outline_rounded,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(doctor: doctor)));
              },
              borderColor: AppColors.primaryColor,
              textColor: AppColors.primaryColor,
              iconColor: AppColors.primaryColor,
              backgroundColor: Color(0xFFE8F7F6),
            ),
            const SizedBox(height: 12),
            OutlineButton(
              text: "Call Doctor",
              icon: Icons.phone_in_talk_rounded,
              onPressed: () {},
              borderColor: AppColors.primaryColor,
              textColor: AppColors.primaryColor,
              iconColor: AppColors.primaryColor,
              backgroundColor: Colors.transparent,
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
        child: OutlineButton(
          text: "Book Appointment",
          icon: Icons.calendar_month_rounded,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BookAppointmentsScreen(doctor: doctor, user: user),
            ),
          ),
          backgroundColor: AppColors.primaryColor,
          textColor: Colors.white,
          borderColor: AppColors.primaryColor,
          iconColor: Colors.white,
        ),
      ),
    );
  }
}

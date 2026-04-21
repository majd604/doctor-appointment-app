import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/widgets/time_container.dart';
import 'package:doctor_appointment_app/features/navigation/presentation/screens/main_navigation.dart';

import 'package:flutter/material.dart';

class SuccessBooking extends StatelessWidget {
  const SuccessBooking({
    super.key,
    required this.doctorName,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.patientName,
  });
  final String doctorName;
  final String appointmentDate;
  final String appointmentTime;
  final String patientName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset('images/done.png', height: 200)),
            Text("Congratulations!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text.rich(
              TextSpan(
                text: "$patientName ,",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                children: [
                  TextSpan(
                    text: " your appointment with ",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: "$doctorName ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                children: [
                  TextSpan(
                    text: "has been created.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            TimeContainer(icon: Icons.calendar_month_rounded, time: appointmentDate),
            TimeContainer(icon: Icons.access_time_rounded, time: appointmentTime),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40.0, left: 20, right: 20),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => MainNavigation(initialIndex: 2)),
              (route) => false,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 14),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_month_rounded, size: 20),
              Text("See Appointments", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

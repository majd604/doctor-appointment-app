import 'package:doctor_appointment_app/features/auth/presentation/widgets/forget_password_dialog.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          showDialog(context: context, builder: (_) => const ForgetPasswordDialog());
        },
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_app/core/helpers/app_snackbar.dart';
import 'package:doctor_appointment_app/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class ForgetPasswordDialog extends StatefulWidget {
  const ForgetPasswordDialog({super.key});

  @override
  State<ForgetPasswordDialog> createState() => _ForgetPasswordDialogState();
}

class _ForgetPasswordDialogState extends State<ForgetPasswordDialog> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  Future<void> sendResetLink() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      AppSnackbar.showError(context, "Please enter your email");
      return;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      AppSnackbar.showError(context, "Please enter a valid email address");
      return;
    }

    setState(() => isLoading = true);

    try {
      await AuthRepository().forgotPassword(email: email);

      Navigator.pop(context);

      AppSnackbar.showSuccess(context, "If this email is registered, a reset link has been sent.");
    } on FirebaseException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-email':
          message = "The email address is not valid.";
          break;
        case 'user-not-found':
          message = "No user found with this email.";
          break;
        case 'network-request-failed':
          message = 'check your internet connection and try again';
          break;
        case 'too-many-requests':
          message = 'Too many attempts. Please try again later.';
          break;
        default:
          message = "Something went wrong. Please try again.";
      }
      AppSnackbar.showError(context, message);
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock_reset_rounded, size: 40, color: Color(0xFF0B7A75)),
            const SizedBox(height: 14),

            const Text("Reset Password", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),

            const SizedBox(height: 10),

            const Text(
              "Enter your email to receive reset link",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Enter your email",
                filled: true,
                fillColor: const Color(0xFFF3F4F6),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : sendResetLink,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B7A75),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Send Reset Link", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

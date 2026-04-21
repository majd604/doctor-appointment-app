import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class NoteField extends StatelessWidget {
  const NoteField({super.key, required this.noteController});

  final TextEditingController noteController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: noteController,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Write a note for the doctor...',
        hintStyle: const TextStyle(color: Color(0xFF7C8796)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
        ),
      ),
    );
  }
}

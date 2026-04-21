// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:doctor_appointment_app/core/helpers/app_snackbar.dart';
import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:doctor_appointment_app/features/appointments/data/model/appointmen_model.dart';
import 'package:doctor_appointment_app/features/appointments/data/services/appointment_service.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/screen/success_booking.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/widgets/confirm_booking_button.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/widgets/date_selector_card.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/widgets/doctor_info_card_appointments.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/widgets/note_field.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/widgets/time_selector_wrap.dart';
import 'package:doctor_appointment_app/features/auth/data/model/user_model.dart';
import 'package:doctor_appointment_app/features/home/data/models/doctor_model.dart';
import 'package:flutter/material.dart';

class BookAppointmentsScreen extends StatefulWidget {
  const BookAppointmentsScreen({super.key, required this.doctor, required this.user});

  final DoctorModel doctor;
  final UserModel user;

  @override
  State<BookAppointmentsScreen> createState() => _BookAppointmentsScreenState();
}

class _BookAppointmentsScreenState extends State<BookAppointmentsScreen> {
  bool isLoading = false;
  DateTime? selectedDate;
  String? selectedTime;
  final TextEditingController noteController = TextEditingController();

  final List<String> availableTimes = const ['09:00 AM', '10:00 AM', '11:00 AM', '01:00 PM', '03:00 PM', '05:00 PM'];

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(colorScheme: const ColorScheme.light(primary: AppColors.primaryColor)),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  String get formattedDate {
    if (selectedDate == null) {
      return 'Choose appointment date';
    }

    return '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: AppColors.cardBg,
        appBar: AppBar(
          title: const Text("New Appointment", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          centerTitle: true,
          backgroundColor: AppColors.cardBg,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor info card
              DoctorInfoCardAppointments(widget: widget),

              const SizedBox(height: 24),

              const Text(
                'Select Date',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
              ),
              const SizedBox(height: 12),

              DateSelectorCard(displayText: formattedDate, onTap: pickDate, isSelected: selectedDate != null),

              const SizedBox(height: 24),

              const Text(
                'Select Time',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
              ),
              const SizedBox(height: 12),

              TimeSelectorWrap(
                availableTimes: availableTimes,
                selectedTime: selectedTime,
                onTimeSelected: (time) {
                  setState(() {
                    selectedTime = time;
                  });
                },
              ),

              const SizedBox(height: 24),

              const Text(
                'Add Note',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
              ),
              const SizedBox(height: 12),

              NoteField(noteController: noteController),

              const SizedBox(height: 32),

              //Confirm Button
              ConfirmBookingButton(
                isLoading: isLoading,
                onPressed: () async {
                  if (isLoading) return;
                  setState(() {
                    isLoading = true;
                  });

                  if (selectedDate == null) {
                    AppSnackbar.showError(context, "Please select a date for the appointment.");
                    setState(() {
                      isLoading = false;
                    });
                    return;
                  } else if (selectedTime == null) {
                    AppSnackbar.showError(context, "Please select a time for the appointment.");
                    setState(() {
                      isLoading = false;
                    });
                    return;
                  }

                  final appointment = AppointmentModel(
                    id: '',
                    userId: widget.user.id,
                    patientName: widget.user.fullName,
                    doctorId: widget.doctor.id,
                    doctorName: widget.doctor.name,
                    doctorImageUrl: widget.doctor.imageUrl,
                    date: selectedDate!,
                    time: selectedTime!,
                    createdAt: DateTime.now(),
                    doctorSpecialty: widget.doctor.specialty,
                    status: 'Pending',
                    notes: noteController.text.trim().isEmpty ? null : noteController.text.trim(),
                  );

                  try {
                    await AppointmentService().createAppointment(appointment);

                    AppSnackbar.showSuccess(context, "Appointment booked successfully!");

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessBooking(
                          doctorName: widget.doctor.name,
                          appointmentDate: formattedDate,
                          appointmentTime: selectedTime!,
                          patientName: widget.user.fullName,
                        ),
                      ),
                    );
                  } catch (e) {
                    AppSnackbar.showError(context, "Failed to book appointment: $e");
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:doctor_appointment_app/core/helpers/app_dialogs.dart';
import 'package:doctor_appointment_app/features/appointments/data/model/appointmen_model.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/bloc/appointments_bloc.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/widgets/appointment_date_time_row.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/widgets/appointment_details_sheet.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/widgets/appointment_filled_action_button.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/widgets/appointment_outlined_action_button.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/widgets/doctor_image.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/widgets/doctor_info.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/widgets/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key, required this.appointment});

  final AppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 14, offset: const Offset(0, 5))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              DoctorImage(imageUrl: appointment.doctorImageUrl),
              const SizedBox(width: 14),
              Expanded(
                child: DoctorInfo(
                  doctorName: appointment.doctorName,
                  specialty: appointment.doctorSpecialty ?? "No Specialty",
                ),
              ),
              StatusBadge(status: appointment.status),
            ],
          ),
          const SizedBox(height: 16),
          AppointmentDateTimeRow(dateText: _formatDate(appointment.date), timeText: appointment.time),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: AppointmentOutlinedActionButton(
                  text: "Delete",
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    final shouldDialog = await AppDialogs.showDeleteDialog(context: context);

                    if (shouldDialog != true) return;

                    await context.read<AppointmentsBloc>().appointmentService.deleteAppointment(appointment.id);

                    messenger
                      ..hideCurrentSnackBar()
                      ..showSnackBar(const SnackBar(content: Text('Appointment deleted successfully')));
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppointmentFilledActionButton(
                  text: "Details",
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => AppointmentDetailsSheet(appointment: appointment),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    return '${date.day} ${monthNames[date.month - 1]} ${date.year}';
  }
}

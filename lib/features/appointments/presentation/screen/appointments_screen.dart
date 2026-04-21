// ignore_for_file: deprecated_member_use

import 'package:doctor_appointment_app/core/loading/list_shimmer.dart';
import 'package:doctor_appointment_app/core/utils/app_colors.dart';

import 'package:doctor_appointment_app/features/appointments/data/services/appointment_service.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/bloc/appointments_bloc.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/bloc/appointments_event.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/bloc/appointments_state.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/widgets/appointment_card.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/widgets/appointments_header.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/widgets/appointments_message_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return BlocProvider(
      create: (_) => AppointmentsBloc(appointmentService: AppointmentService())..add(LoadAppointments(userId)),
      child: Scaffold(
        backgroundColor: AppColors.cardBg,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: const Text("My Appointments", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          centerTitle: true,
          backgroundColor: AppColors.cardBg,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<AppointmentsBloc, AppointmentsState>(
            builder: (context, state) {
              if (state is AppointmentsLoading) {
                return ListShimmer(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  itemCount: 4,
                  scrollDirection: Axis.vertical,
                );
              }

              if (state is AppointmentsError) {
                return AppointmentsMessageState(
                  icon: Icons.error_outline_rounded,
                  title: "Something went wrong",
                  subtitle: state.message,
                );
              }

              if (state is AppointmentsLoaded && state.appointments.isEmpty) {
                return const AppointmentsMessageState(
                  icon: Icons.calendar_month_rounded,
                  title: "No appointments yet",
                  subtitle: "Your booked appointments will appear here.",
                );
              }

              if (state is AppointmentsLoaded) {
                final appointments = state.appointments;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppointmentsHeader(),
                    const SizedBox(height: 18),
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: appointments.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final appointment = appointments[index];
                          return AppointmentCard(appointment: appointment);
                        },
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}

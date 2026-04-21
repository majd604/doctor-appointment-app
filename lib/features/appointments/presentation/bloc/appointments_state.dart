import 'package:doctor_appointment_app/features/appointments/data/model/appointmen_model.dart';

abstract class AppointmentsState {}

class AppointmentsInitial extends AppointmentsState {}

class AppointmentsLoading extends AppointmentsState {}

class AppointmentsLoaded extends AppointmentsState {
  final List<AppointmentModel> appointments;

  AppointmentsLoaded(this.appointments);
}

class AppointmentsError extends AppointmentsState {
  final String message;

  AppointmentsError(this.message);
}

import 'package:doctor_appointment_app/features/appointments/data/services/appointment_service.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/bloc/appointments_event.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/bloc/appointments_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  final AppointmentService appointmentService;

  AppointmentsBloc({required this.appointmentService}) : super(AppointmentsInitial()) {
    on<LoadAppointments>(_onLoadAppointments);
  }

  Future<void> _onLoadAppointments(LoadAppointments event, Emitter<AppointmentsState> emit) async {
    emit(AppointmentsLoading());

    await emit.forEach(
      appointmentService.getUserAppointmentsStream(event.userId),
      onData: (appointments) => AppointmentsLoaded(appointments),
      onError: (_, __) => AppointmentsError("Failed to load appointments"),
    );
  }
}

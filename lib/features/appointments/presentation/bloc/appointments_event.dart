abstract class AppointmentsEvent {}

class LoadAppointments extends AppointmentsEvent {
  final String userId;

  LoadAppointments(this.userId);
}

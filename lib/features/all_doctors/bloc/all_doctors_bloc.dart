import 'package:doctor_appointment_app/features/all_doctors/bloc/all_doctors_event.dart';
import 'package:doctor_appointment_app/features/all_doctors/bloc/all_doctors_state.dart';
import 'package:doctor_appointment_app/features/home/data/services/doctor_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDoctorsBloc extends Bloc<AllDoctorsEvent, AllDoctorsState> {
  final DoctorService doctorService;
  AllDoctorsBloc({required this.doctorService}) : super(AllDoctorsInitial()) {
    on<LoadAllDoctors>((event, emit) async {
      emit(AllDoctorsLoading());
      try {
        // Replace with actual data fetching logic
        final doctors = await doctorService.getDoctors();
        emit(AllDoctorsLoaded(doctors: doctors));
      } catch (e) {
        emit(AllDoctorsError(message: 'Failed to load doctors'));
      }
    });
  }
}

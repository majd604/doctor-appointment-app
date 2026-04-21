import 'package:doctor_appointment_app/features/home/data/models/doctor_model.dart';
import 'package:equatable/equatable.dart';

abstract class AllDoctorsState extends Equatable {
  @override
  List<Object> get props => [];
}

class AllDoctorsInitial extends AllDoctorsState {}

class AllDoctorsLoading extends AllDoctorsState {}

class AllDoctorsLoaded extends AllDoctorsState {
  final List<DoctorModel> doctors;

  AllDoctorsLoaded({required this.doctors});

  @override
  List<Object> get props => [doctors];
}

class AllDoctorsError extends AllDoctorsState {
  final String message;

  AllDoctorsError({required this.message});

  @override
  List<Object> get props => [message];
}

import 'package:doctor_appointment_app/features/auth/data/model/user_model.dart';
import 'package:doctor_appointment_app/features/home/data/models/category_model.dart';
import 'package:doctor_appointment_app/features/home/data/models/doctor_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<CategoryModel> categories;
  final List<DoctorModel> doctors;
  final UserModel? user;

  HomeLoaded({required this.categories, required this.doctors, this.user});
  @override
  List<Object> get props => [categories, doctors, if (user != null) user!];
}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
  @override
  List<Object> get props => [message];
}

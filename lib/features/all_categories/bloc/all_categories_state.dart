import 'package:doctor_appointment_app/features/home/data/models/category_model.dart';
import 'package:equatable/equatable.dart';

abstract class AllCategoriesState extends Equatable {
  @override
  List<Object> get props => [];
}

class AllCategoriesInitial extends AllCategoriesState {}

class AllCategoriesLoading extends AllCategoriesState {}

class AllCategoriesLoaded extends AllCategoriesState {
  final List<CategoryModel> categories;

  AllCategoriesLoaded({required this.categories});

  @override
  List<Object> get props => [categories];
}

class AllCategoriesError extends AllCategoriesState {
  final String message;

  AllCategoriesError({required this.message});

  @override
  List<Object> get props => [message];
}

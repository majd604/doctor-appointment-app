import 'package:doctor_appointment_app/features/auth/data/model/services/user_service.dart';
import 'package:doctor_appointment_app/features/auth/data/model/user_model.dart';
import 'package:doctor_appointment_app/features/home/data/models/category_model.dart';
import 'package:doctor_appointment_app/features/home/data/models/doctor_model.dart';
import 'package:doctor_appointment_app/features/home/data/services/category_service.dart';
import 'package:doctor_appointment_app/features/home/data/services/doctor_service.dart';
import 'package:doctor_appointment_app/features/home/presentation/bloc/home_event.dart';
import 'package:doctor_appointment_app/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CategoryService categoryService;
  final DoctorService doctorService;
  final UserService userService;

  HomeBloc({required this.categoryService, required this.doctorService, required this.userService})
    : super(HomeInitial()) {
    on<LoadHomeData>((event, emit) async {
      emit(HomeLoading());

      try {
        final results = await Future.wait([
          categoryService.getCategories(),
          doctorService.getDoctors(),
          userService.getCurrentUserData(),
        ]);

        final categories = results[0] as List<CategoryModel>;
        final doctors = results[1] as List<DoctorModel>;
        final user = results[2] as UserModel?;

        emit(HomeLoaded(categories: categories, doctors: doctors, user: user));
      } catch (e) {
        emit(HomeError(message: 'Failed to load home data'));
      }
    });
  }
}

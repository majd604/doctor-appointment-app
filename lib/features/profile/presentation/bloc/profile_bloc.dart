import 'package:doctor_appointment_app/features/auth/data/repositories/auth_repository.dart';
import 'package:doctor_appointment_app/features/auth/data/model/services/user_service.dart';
import 'package:doctor_appointment_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:doctor_appointment_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserService userService;
  final AuthRepository authRepository;

  ProfileBloc({required this.userService, required this.authRepository}) : super(ProfileInitial()) {
    on<LoadProfileData>((event, emit) async {
      emit(ProfileLoading());

      try {
        final user = await userService.getCurrentUserData();

        if (user == null) {
          emit(ProfileError('User data not found'));
          return;
        }

        emit(ProfileLoaded(user));
      } catch (e) {
        emit(ProfileError('Failed to load profile data'));
      }
    });

    on<LogoutRequested>((event, emit) async {
      try {
        emit(ProfileLogoutLoading());
        await Future.delayed(const Duration(milliseconds: 1200)); // Simulate loading time
        await authRepository.logout();
        emit(ProfileLoggedOut());
      } catch (e) {
        emit(ProfileError('Failed to logout'));
      }
    });
  }
}

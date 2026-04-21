import 'package:doctor_appointment_app/features/auth/data/repositories/auth_repository.dart';
import 'package:doctor_appointment_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:doctor_appointment_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final userCredential = await authRepository.login(email: event.email, password: event.password);
        final user = userCredential.user;
        if (user != null && user.emailVerified) {
          emit(AuthSuccess());
        } else {
          emit(AuthError(message: 'Please verify your email before logging in.'));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          emit(AuthError(message: 'No user found for this email.'));
        } else if (e.code == 'wrong-password') {
          emit(AuthError(message: 'Incorrect password.'));
        } else if (e.code == 'invalid-email') {
          emit(AuthError(message: 'Please enter a valid email address.'));
        } else if (e.code == 'invalid-credential') {
          emit(AuthError(message: 'Invalid email or password.'));
        } else {
          emit(AuthError(message: 'Something went wrong. Please try again.'));
        }
      } catch (e) {
        emit(AuthError(message: 'Something went wrong. Please try again.'));
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        await authRepository.register(email: event.email, password: event.password, fullName: event.fullName);

        emit(AuthSuccess());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          emit(AuthError(message: 'This email is already in use.'));
        } else if (e.code == 'weak-password') {
          emit(AuthError(message: 'Password is too weak.'));
        } else if (e.code == 'invalid-email') {
          emit(AuthError(message: 'Please enter a valid email address.'));
        } else {
          emit(AuthError(message: 'Something went wrong. Please try again.'));
        }
      } catch (e) {
        emit(AuthError(message: 'Something went wrong. Please try again.'));
      }
    });
  }
}

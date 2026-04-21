import 'package:doctor_appointment_app/app/routes/app_routes.dart';

import 'package:doctor_appointment_app/features/auth/data/repositories/auth_repository.dart';
import 'package:doctor_appointment_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:doctor_appointment_app/features/auth/presentation/screens/login_screen.dart';
import 'package:doctor_appointment_app/features/auth/presentation/screens/register_screen.dart';

import 'package:doctor_appointment_app/features/navigation/presentation/screens/main_navigation.dart';
import 'package:doctor_appointment_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:doctor_appointment_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
        AppRoutes.login: (context) =>
            BlocProvider(create: (_) => AuthBloc(AuthRepository()), child: const LoginScreen()),
        AppRoutes.register: (context) =>
            BlocProvider(create: (_) => AuthBloc(AuthRepository()), child: const RegisterScreen()),

        AppRoutes.mainNavigation: (context) => const MainNavigation(),
      },
    );
  }
}

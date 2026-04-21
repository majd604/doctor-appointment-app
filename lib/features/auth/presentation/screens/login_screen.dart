// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:doctor_appointment_app/app/routes/app_routes.dart';
import 'package:doctor_appointment_app/core/helpers/app_dialogs.dart';
import 'package:doctor_appointment_app/core/helpers/app_snackbar.dart';
import 'package:doctor_appointment_app/core/utils/validators.dart';
import 'package:doctor_appointment_app/features/auth/data/repositories/auth_repository.dart';
import 'package:doctor_appointment_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:doctor_appointment_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:doctor_appointment_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:doctor_appointment_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:doctor_appointment_app/features/auth/presentation/widgets/divider_row.dart';
import 'package:doctor_appointment_app/features/auth/presentation/widgets/forget_password.dart';
import 'package:doctor_appointment_app/features/auth/presentation/widgets/header_auth_image.dart';
import 'package:doctor_appointment_app/features/auth/presentation/widgets/social_auth_button.dart';
import 'package:doctor_appointment_app/features/auth/presentation/widgets/subtitle_auth_text.dart';
import 'package:doctor_appointment_app/features/auth/presentation/widgets/text_auth_log_or_sign.dart';
import 'package:doctor_appointment_app/features/auth/presentation/widgets/text_form_field_auth.dart';
import 'package:doctor_appointment_app/features/auth/presentation/widgets/title_auth_text.dart';
import 'package:doctor_appointment_app/features/auth/presentation/widgets/title_text_for_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: "majdnouful@gmail.com");
  final TextEditingController passwordController = TextEditingController(text: "12345678");

  bool isObscure = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            AppSnackbar.showError(context, state.message);
          }
          if (state is AuthSuccess) {
            AppSnackbar.showSuccess(context, "Login successful!");
            Navigator.pushReplacementNamed(context, AppRoutes.mainNavigation);
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 12),

                    HeaderAuthImage(),

                    const SizedBox(height: 12),

                    TitleAuthText(text: "Welcome Back!"),

                    const SizedBox(height: 6),

                    SubtitleAuthText(text: "Please sign in to your account"),

                    const SizedBox(height: 28),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const TitleTextForForm(text: "Email :"),
                          const SizedBox(height: 8),

                          TextFormFieldAuth(
                            validator: (value) => AppValidators.validateEmail(value),
                            controller: emailController,
                            hintText: 'Enter your email',
                            prefixIcon: Icons.email_outlined,
                            obscureText: false,
                          ),

                          const SizedBox(height: 16),

                          const TitleTextForForm(text: "Password :"),
                          const SizedBox(height: 8),
                          TextFormFieldAuth(
                            controller: passwordController,
                            validator: (p0) => AppValidators.validatePassword(p0),

                            hintText: 'Enter your password',
                            prefixIcon: Icons.lock_outline,
                            obscureText: isObscure,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                              icon: Icon(isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    const ForgetPassword(),

                    const SizedBox(height: 24),

                    isLoading
                        ? const CircularProgressIndicator(color: Color(0xFF0B7A75))
                        : AuthButton(
                            text: "Login",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                // Perform login action
                                context.read<AuthBloc>().add(
                                  LoginRequested(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                              }
                            },
                          ),

                    const SizedBox(height: 28),

                    const DividerRow(),

                    const SizedBox(height: 24),

                    SocialAuthButton(
                      onTap: () async {
                        try {
                          AppDialogs.showLoadingDialog(context: context, message: 'Signing in with Google...');

                          final userCredential = await AuthRepository().signInWithGoogle();

                          Navigator.pop(context); // close loading

                          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainNavigation, (route) => false);
                        } catch (e) {
                          Navigator.pop(context); // close loading
                          AppSnackbar.showError(context, e.toString());
                        }
                      },
                    ),

                    const SizedBox(height: 32),

                    TextAuthLogOrSign(
                      onTap: () => Navigator.pushNamed(context, AppRoutes.register),
                      text1: "Don't have an account? ",
                      text2: "Sign Up",
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

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

import 'package:doctor_appointment_app/features/auth/presentation/widgets/social_auth_button.dart';

import 'package:doctor_appointment_app/features/auth/presentation/widgets/subtitle_auth_text.dart';
import 'package:doctor_appointment_app/features/auth/presentation/widgets/text_auth_log_or_sign.dart';
import 'package:doctor_appointment_app/features/auth/presentation/widgets/text_form_field_auth.dart';
import 'package:doctor_appointment_app/features/auth/presentation/widgets/title_auth_text.dart';
import 'package:doctor_appointment_app/features/auth/presentation/widgets/title_text_for_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            AppSnackbar.showError(context, state.message);
          }
          if (state is AuthSuccess) {
            AppSnackbar.showSuccess(context, "Registration successful, please check your email for verification");
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            });
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
                    const SizedBox(height: 25),
                    TitleAuthText(text: "Create Account"),
                    const SizedBox(height: 8),
                    SubtitleAuthText(text: "Fill in your details to create your account"),
                    const SizedBox(height: 32),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TitleTextForForm(text: "Full Name"),
                          const SizedBox(height: 8),
                          TextFormFieldAuth(
                            controller: fullNameController,
                            hintText: "Full Name",
                            prefixIcon: Icons.person,
                            obscureText: false,
                            validator: AppValidators.validateFullName,
                          ),
                          const SizedBox(height: 16),
                          TitleTextForForm(text: "Email"),
                          const SizedBox(height: 8),
                          TextFormFieldAuth(
                            controller: emailController,
                            hintText: "Enter your email",
                            prefixIcon: Icons.email,
                            obscureText: false,
                            validator: AppValidators.validateEmail,
                          ),
                          const SizedBox(height: 16),
                          TitleTextForForm(text: "Password"),
                          const SizedBox(height: 8),
                          TextFormFieldAuth(
                            controller: passwordController,

                            hintText: "Password",
                            prefixIcon: Icons.lock,
                            obscureText: isPasswordObscure,
                            validator: AppValidators.validatePassword,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordObscure = !isPasswordObscure;
                                });
                              },
                              icon: Icon(isPasswordObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TitleTextForForm(text: "Confirm Password"),
                          const SizedBox(height: 8),
                          TextFormFieldAuth(
                            controller: confirmPasswordController,
                            hintText: "Confirm Password",
                            prefixIcon: Icons.lock,
                            obscureText: isConfirmPasswordObscure,
                            validator: (value) => AppValidators.validateConfirmPassword(value, passwordController.text),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isConfirmPasswordObscure = !isConfirmPasswordObscure;
                                });
                              },
                              icon: Icon(
                                isConfirmPasswordObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    isLoading
                        ? const CircularProgressIndicator(color: Color(0xFF0B7A75))
                        : AuthButton(
                            text: "Register",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  RegisterRequested(
                                    fullName: fullNameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                              }
                            },
                          ),
                    const SizedBox(height: 16),
                    TextAuthLogOrSign(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      text1: "Already have an account? ",
                      text2: "Log In",
                    ),
                    const SizedBox(height: 25),

                    SocialAuthButton(
                      onTap: () async {
                        try {
                          AppDialogs.showLoadingDialog(context: context, message: 'Signing in with Google...');

                          final userCredential = await AuthRepository().signInWithGoogle();

                          Navigator.pop(context); // close loading

                          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
                        } catch (e) {
                          Navigator.pop(context); // close loading
                          AppSnackbar.showError(context, e.toString());
                        }
                      },
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

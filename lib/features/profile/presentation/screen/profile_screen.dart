// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:doctor_appointment_app/app/routes/app_routes.dart';
import 'package:doctor_appointment_app/core/helpers/app_dialogs.dart';
import 'package:doctor_appointment_app/core/helpers/app_snackbar.dart';
import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:doctor_appointment_app/features/auth/data/model/services/user_service.dart';
import 'package:doctor_appointment_app/features/auth/data/repositories/auth_repository.dart';
import 'package:doctor_appointment_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:doctor_appointment_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:doctor_appointment_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:doctor_appointment_app/features/profile/presentation/widgets/logout_button.dart';
import 'package:doctor_appointment_app/features/profile/presentation/widgets/profile_tile.dart';
import 'package:doctor_appointment_app/features/profile/presentation/widgets/profile_top_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(userService: UserService(), authRepository: AuthRepository())..add(LoadProfileData()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLogoutLoading) {
            AppDialogs.showLoadingDialog(context: context, message: 'Logging out...');
          }

          if (state is ProfileLoggedOut) {
            Navigator.of(context, rootNavigator: true).pop(); // Close the loading dialog
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
          }
          if (state is ProfileError) {
            AppSnackbar.showError(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator(color: AppColors.primaryColor)),
            );
          }

          if (state is ProfileError) {
            return Scaffold(body: Center(child: Text(state.message)));
          }

          if (state is ProfileLoaded) {
            return Scaffold(
              backgroundColor: const Color(0xFFF7F7F7),
              body: SafeArea(
                child: Column(
                  children: [
                    // 🔥 Header
                    const SizedBox(height: 10),
                    const Text("Profile", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

                    const SizedBox(height: 20),

                    // 🔥 Profile Info
                    ProfileTopSection(
                      name: state.user.fullName,
                      email: state.user.email,
                      imageUrl: state.user.imageUrl,
                      publicId: state.user.publicId,
                    ),

                    const SizedBox(height: 20),

                    // 🔥 MENU
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          ProfileTile(icon: Icons.notifications_none, title: "Notifications"),
                          ProfileTile(icon: Icons.language, title: "Language"),
                          ProfileTile(icon: Icons.dark_mode_outlined, title: "Theme"),
                          ProfileTile(
                            icon: Icons.info_outline,
                            title: "About App",
                            onTap: () {
                              AppDialogs.showAboutAppDialog(context: context);
                            },
                          ),
                        ],
                      ),
                    ),

                    // 🔥 Logout
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: LogoutButton(
                        onPressed: () async {
                          final shouldLogout = await AppDialogs.showLogoutDialog(context: context);
                          if (shouldLogout == true) {
                            context.read<ProfileBloc>().add(LogoutRequested());
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

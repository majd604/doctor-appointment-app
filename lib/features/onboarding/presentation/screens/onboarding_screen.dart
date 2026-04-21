// ignore_for_file: use_build_context_synchronously

import 'package:doctor_appointment_app/app/routes/app_routes.dart';
import 'package:doctor_appointment_app/features/onboarding/presentation/widgets/image_onboarding.dart';
import 'package:doctor_appointment_app/features/onboarding/presentation/widgets/index_row.dart';
import 'package:doctor_appointment_app/features/onboarding/presentation/widgets/next_button.dart';
import 'package:doctor_appointment_app/features/onboarding/presentation/widgets/skip_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  PageController pageController = PageController();
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              children: [
                ImageOnboarding(image: 'images/onboarding/onboarding1.jpg'),
                ImageOnboarding(image: 'images/onboarding/onboarding2.jpg'),
                ImageOnboarding(image: 'images/onboarding/onboarding3.jpg'),
              ],
            ),
          ),
          Positioned(bottom: 100, left: 0, right: 0, child: IndexRow(currentPage: currentPage)),
          Positioned(
            top: 40,
            right: 20,
            child: SkipButton(
              onTap: () {
                pageController.animateToPage(
                  2,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutCirc,
                );
              },
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: NextButton(
              onPressed: () async {
                if (currentPage < 2) {
                  pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOutCirc);
                } else {
                  // Navigate to the next screen, e.g., LoginScreen
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('hasSeenOnboarding', true);
                  if (!mounted) return;
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                }
              },
              title: currentPage == 2 ? "Get Started" : "Next",
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:doctor_appointment_app/app/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    Future.delayed(const Duration(seconds: 5), checkNavigation);
  }

  void checkNavigation() {
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      final hasSeen = value.getBool('hasSeenOnboarding') ?? false;
      final user = FirebaseAuth.instance.currentUser;
      if (hasSeen == false) {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
      } else if (hasSeen == true && user == null) {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      } else {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, AppRoutes.mainNavigation);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F8),
      body: Stack(
        children: [
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Image.asset("images/logo/doctor-app-logo.png", width: 250, height: 250),
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(child: LoadingAnimationWidget.staggeredDotsWave(color: const Color(0xFF0B7A75), size: 40)),
          ),
        ],
      ),
    );
  }
}

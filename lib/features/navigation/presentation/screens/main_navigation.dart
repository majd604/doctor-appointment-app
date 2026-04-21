import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:doctor_appointment_app/features/appointments/presentation/screen/appointments_screen.dart';
import 'package:doctor_appointment_app/features/auth/data/model/services/user_service.dart';
import 'package:doctor_appointment_app/features/message/presentation/screen/message_screen.dart';
import 'package:doctor_appointment_app/features/home/data/services/category_service.dart';
import 'package:doctor_appointment_app/features/home/data/services/doctor_service.dart';
import 'package:doctor_appointment_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:doctor_appointment_app/features/home/presentation/bloc/home_event.dart';
import 'package:doctor_appointment_app/features/home/presentation/screen/home_screen.dart';
import 'package:doctor_appointment_app/features/profile/presentation/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key, this.initialIndex = 0});
  final int initialIndex;

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int currentIndex;
  late final HomeBloc homeBloc;
  List<Widget> screens = [const HomeScreen(), const MessageScreen(), const AppointmentsScreen(), const ProfileScreen()];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    homeBloc = HomeBloc(categoryService: CategoryService(), doctorService: DoctorService(), userService: UserService())
      ..add(LoadHomeData());
  }

  @override
  void dispose() {
    homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homeBloc,
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          index: currentIndex,
          onTap: (index) => {
            setState(() => currentIndex = index),
            setState(() {
              if (index == 0) {
                homeBloc.add(LoadHomeData());
              }
            }),
          },
          height: 60,
          backgroundColor: Colors.transparent,
          color: const Color(0xFF0B7A75),
          buttonBackgroundColor: const Color(0xFF0B7A75),
          animationDuration: const Duration(milliseconds: 300),
          items: const [
            Icon(Icons.home_rounded, color: Colors.white),
            Icon(Icons.message_outlined, color: Colors.white),
            Icon(Icons.calendar_month_outlined, color: Colors.white),
            Icon(Icons.person_outline_rounded, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

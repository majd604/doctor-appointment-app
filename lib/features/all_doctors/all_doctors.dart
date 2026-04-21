// ignore_for_file: deprecated_member_use
import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:doctor_appointment_app/features/all_doctors/bloc/all_doctors_bloc.dart';
import 'package:doctor_appointment_app/features/all_doctors/bloc/all_doctors_event.dart';

import 'package:doctor_appointment_app/features/all_doctors/widgets/all_doctors_body.dart';
import 'package:doctor_appointment_app/features/all_doctors/widgets/all_doctors_header_card.dart';

import 'package:doctor_appointment_app/features/home/data/services/doctor_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDoctorsScreen extends StatelessWidget {
  const AllDoctorsScreen({super.key, this.selectedCategory});
  final String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AllDoctorsBloc(doctorService: DoctorService())..add(LoadAllDoctors()),
      child: Scaffold(
        backgroundColor: AppColors.cardBg,
        appBar: AppBar(
          backgroundColor: AppColors.cardBg,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text(
            selectedCategory == null || selectedCategory!.isEmpty ? "All Doctors" : selectedCategory!,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1F2937)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AllDoctorsHeaderCard(),
              const SizedBox(height: 18),
              Expanded(child: AllDoctorsBody(selectedCategory: selectedCategory)),
            ],
          ),
        ),
      ),
    );
  }
}

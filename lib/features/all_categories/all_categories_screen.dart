// ignore_for_file: deprecated_member_use

import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:doctor_appointment_app/features/all_categories/bloc/all_categories_bloc.dart';
import 'package:doctor_appointment_app/features/all_categories/bloc/all_categories_event.dart';
import 'package:doctor_appointment_app/features/all_categories/widgets/all_category_body.dart';
import 'package:doctor_appointment_app/features/all_categories/widgets/all_category_header_card.dart';
import 'package:doctor_appointment_app/features/home/data/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AllCategoriesBloc(categoryService: CategoryService())..add(LoadAllCategories()),
      child: Scaffold(
        backgroundColor: AppColors.cardBg,
        appBar: AppBar(
          backgroundColor: AppColors.cardBg,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: const Text(
            "All Categories",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1F2937)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AllCategoriesHeaderCard(),
              SizedBox(height: 18),
              Expanded(child: AllCategoriesBody()),
            ],
          ),
        ),
      ),
    );
  }
}

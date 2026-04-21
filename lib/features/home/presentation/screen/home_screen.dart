// ignore_for_file: deprecated_member_use

import 'package:doctor_appointment_app/core/helpers/get_first_name.dart';
import 'package:doctor_appointment_app/core/loading/list_shimmer.dart';
import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:doctor_appointment_app/core/utils/icon_mapper.dart';
import 'package:doctor_appointment_app/features/all_categories/all_categories_screen.dart';
import 'package:doctor_appointment_app/features/all_doctors/all_doctors.dart';
import 'package:doctor_appointment_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:doctor_appointment_app/features/home/presentation/bloc/home_state.dart';
import 'package:doctor_appointment_app/features/home/presentation/screen/doctor_details_screen.dart';
import 'package:doctor_appointment_app/features/home/presentation/widgets/build_banner.dart';
import 'package:doctor_appointment_app/features/home/presentation/widgets/category_card.dart';
import 'package:doctor_appointment_app/features/home/presentation/widgets/doctor_card.dart';
import 'package:doctor_appointment_app/features/home/presentation/widgets/home_header.dart';
import 'package:doctor_appointment_app/features/home/presentation/widgets/home_header_shimmer.dart';
import 'package:doctor_appointment_app/features/home/presentation/widgets/search_field.dart';
import 'package:doctor_appointment_app/features/home/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBg,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is HomeLoading || state is HomeInitial)
                    const HomeHeaderShimmer()
                  else if (state is HomeLoaded && state.user != null)
                    HomeHeader(
                      username: GetFirstName.getFirstName(state.user!.fullName),
                      userImageUrl: state.user!.imageUrl ?? "",
                      userImageCacheKey: state.user!.publicId ?? state.user!.imageUrl ?? "",
                    )
                  else
                    const HomeHeaderShimmer(),

                  const SizedBox(height: 24),
                  const BuildBanner(),
                  const SizedBox(height: 20),
                  const SearchField(),
                  const SizedBox(height: 28),

                  SectionHeader(
                    title: "Categories",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AllCategoriesScreen()));
                    },
                  ),
                  const SizedBox(height: 16),

                  if (state is HomeLoading || state is HomeInitial)
                    const SizedBox(
                      height: 128,
                      child: ListShimmer(height: 80, width: 90, itemCount: 3, scrollDirection: Axis.horizontal),
                    )
                  else if (state is HomeLoaded)
                    _buildCategories(state),

                  const SizedBox(height: 28),

                  SectionHeader(
                    title: "Top Doctors",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AllDoctorsScreen()));
                    },
                  ),
                  const SizedBox(height: 16),

                  if (state is HomeLoading || state is HomeInitial)
                    const ListShimmer(height: 100, width: double.infinity, itemCount: 3, scrollDirection: Axis.vertical)
                  else if (state is HomeLoaded)
                    _buildDoctors(state, context),

                  if (state is HomeError)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategories(HomeLoaded state) {
    final categories = state.categories.take(3).toList();

    return SizedBox(
      height: 128,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryCard(title: category.name, icon: IconMapper.getIcon(category.icon));
        },
      ),
    );
  }

  Widget _buildDoctors(HomeLoaded state, BuildContext context) {
    final doctors = state.doctors.take(3).toList();
    final user = state.user;

    return Column(
      children: doctors.map((doctor) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: () {
              if (user == null) return;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DoctorDetailsScreen(doctor: doctor, user: user),
                ),
              );
            },
            child: DoctorCard(
              name: doctor.name,
              specialty: doctor.specialty,
              rating: doctor.rating.toString(),
              imageUrl: doctor.imageUrl,
            ),
          ),
        );
      }).toList(),
    );
  }
}

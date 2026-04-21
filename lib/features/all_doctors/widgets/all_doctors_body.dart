import 'package:doctor_appointment_app/core/loading/list_shimmer.dart';
import 'package:doctor_appointment_app/features/all_doctors/bloc/all_doctors_bloc.dart';
import 'package:doctor_appointment_app/features/all_doctors/bloc/all_doctors_state.dart';
import 'package:doctor_appointment_app/features/all_doctors/widgets/all_doctors_message_state.dart';
import 'package:doctor_appointment_app/features/auth/data/model/services/user_service.dart';
import 'package:doctor_appointment_app/features/auth/data/model/user_model.dart';
import 'package:doctor_appointment_app/features/home/presentation/screen/doctor_details_screen.dart';
import 'package:doctor_appointment_app/features/home/presentation/widgets/doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDoctorsBody extends StatelessWidget {
  const AllDoctorsBody({super.key, this.selectedCategory});
  final String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllDoctorsBloc, AllDoctorsState>(
      builder: (context, state) {
        if (state is AllDoctorsLoading) {
          return ListShimmer(
            height: 100,
            width: MediaQuery.of(context).size.width,
            itemCount: 5,
            scrollDirection: Axis.vertical,
          );
        }

        if (state is AllDoctorsError) {
          return AllDoctorsMessageState(
            icon: Icons.error_outline_rounded,
            title: "Something went wrong",
            subtitle: state.message,
          );
        }

        if (state is AllDoctorsLoaded && state.doctors.isEmpty) {
          return const AllDoctorsMessageState(
            icon: Icons.person_search_rounded,
            title: "No doctors found",
            subtitle: "There are no doctors available right now.",
          );
        }

        if (state is AllDoctorsLoaded) {
          return FutureBuilder<UserModel?>(
            future: UserService().getCurrentUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListShimmer(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  itemCount: 4,
                  scrollDirection: Axis.vertical,
                );
              }

              if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
                return const AllDoctorsMessageState(
                  icon: Icons.person_off_rounded,
                  title: "User data not found",
                  subtitle: "Unable to load your profile data right now.",
                );
              }

              final user = snapshot.data!;

              final doctors = selectedCategory == null || selectedCategory!.isEmpty
                  ? state.doctors
                  : state.doctors.where((doctor) {
                      return doctor.specialty.toLowerCase() == selectedCategory!.toLowerCase();
                    }).toList();

              if (doctors.isEmpty) {
                return const AllDoctorsMessageState(
                  icon: Icons.person_search_rounded,
                  title: "No doctors found",
                  subtitle: "No doctors available in this specialty yet.",
                );
              }

              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: doctors.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final doctor = doctors[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () {
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
                  );
                },
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}

import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:doctor_appointment_app/features/all_categories/bloc/all_categories_bloc.dart';
import 'package:doctor_appointment_app/features/all_categories/bloc/all_categories_state.dart';
import 'package:doctor_appointment_app/features/all_categories/widgets/categorey_message_state.dart';
import 'package:doctor_appointment_app/features/all_categories/widgets/caterory_grid_card.dart';
import 'package:doctor_appointment_app/features/all_doctors/all_doctors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCategoriesBody extends StatelessWidget {
  const AllCategoriesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllCategoriesBloc, AllCategoriesState>(
      builder: (context, state) {
        if (state is AllCategoriesLoading || state is AllCategoriesInitial) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
        }

        if (state is AllCategoriesError) {
          return CategoryMessageState(
            icon: Icons.error_outline_rounded,
            title: "Something went wrong",
            subtitle: state.message,
          );
        }

        if (state is AllCategoriesLoaded && state.categories.isEmpty) {
          return const CategoryMessageState(
            icon: Icons.category_outlined,
            title: "No categories found",
            subtitle: "There are no categories available right now.",
          );
        }

        if (state is AllCategoriesLoaded) {
          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.95,
            ),
            itemBuilder: (context, index) {
              final category = state.categories[index];

              return CategoryGridCard(
                title: category.name,
                iconName: category.icon,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AllDoctorsScreen(selectedCategory: category.name)),
                  );
                },
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

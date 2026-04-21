import 'package:doctor_appointment_app/features/all_categories/bloc/all_categories_event.dart';
import 'package:doctor_appointment_app/features/all_categories/bloc/all_categories_state.dart';
import 'package:doctor_appointment_app/features/home/data/services/category_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCategoriesBloc extends Bloc<AllCategoriesEvent, AllCategoriesState> {
  final CategoryService categoryService;
  AllCategoriesBloc({required this.categoryService}) : super(AllCategoriesInitial()) {
    on<LoadAllCategories>((event, emit) async {
      emit(AllCategoriesLoading());
      try {
        final categories = await categoryService.getCategories();
        emit(AllCategoriesLoaded(categories: categories));
      } catch (e) {
        emit(AllCategoriesError(message: 'Failed to load categories'));
      }
    });
  }
}

import 'package:equatable/equatable.dart';

abstract class AllCategoriesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadAllCategories extends AllCategoriesEvent {}

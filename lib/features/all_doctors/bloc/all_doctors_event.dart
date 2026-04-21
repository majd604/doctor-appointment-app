import 'package:equatable/equatable.dart';

abstract class AllDoctorsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadAllDoctors extends AllDoctorsEvent {}

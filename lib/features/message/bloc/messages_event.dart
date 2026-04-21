import 'package:equatable/equatable.dart';

abstract class MessagesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUserConversations extends MessagesEvent {
  final String userId;

  LoadUserConversations({required this.userId});

  @override
  List<Object?> get props => [userId];
}

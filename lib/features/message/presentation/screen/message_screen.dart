// ignore_for_file: deprecated_member_use

import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:doctor_appointment_app/features/message/bloc/messages_bloc.dart';
import 'package:doctor_appointment_app/features/message/bloc/messages_event.dart';
import 'package:doctor_appointment_app/features/message/data/services/message_service.dart';
import 'package:doctor_appointment_app/features/message/presentation/widgets/messages_body.dart';
import 'package:doctor_appointment_app/features/message/presentation/widgets/messages_header_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;

    return BlocProvider(
      create: (_) =>
          MessagesBloc(messageService: MessageService())..add(LoadUserConversations(userId: currentUser.uid)),
      child: Scaffold(
        backgroundColor: AppColors.cardBg,
        appBar: AppBar(
          backgroundColor: AppColors.cardBg,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            "Messages",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MessagesHeaderCard(),
              SizedBox(height: 18),
              Expanded(child: MessagesBody()),
            ],
          ),
        ),
      ),
    );
  }
}

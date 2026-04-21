// ignore_for_file: deprecated_member_use

import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:doctor_appointment_app/features/home/data/models/doctor_model.dart';
import 'package:doctor_appointment_app/features/message/data/services/message_service.dart';
import 'package:doctor_appointment_app/features/message/presentation/widgets/chat_app_bar.dart';
import 'package:doctor_appointment_app/features/message/presentation/widgets/chat_input_field.dart';
import 'package:doctor_appointment_app/features/message/presentation/widgets/chat_messages_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.doctor});

  final DoctorModel doctor;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Future<String> conversationFuture;

  @override
  void initState() {
    super.initState();

    final currentUser = FirebaseAuth.instance.currentUser!;

    conversationFuture = MessageService().createOrGetConversation(
      userId: currentUser.uid,
      userName: currentUser.displayName ?? currentUser.email ?? 'User',
      doctorId: widget.doctor.id,
      doctorName: widget.doctor.name,
      doctorImageUrl: widget.doctor.imageUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      backgroundColor: AppColors.cardBg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: ChatAppBar(doctor: widget.doctor),
      ),
      body: FutureBuilder<String>(
        future: conversationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Failed to open conversation'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Conversation not found'));
          }

          final conversationId = snapshot.data!;

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            behavior: HitTestBehavior.translucent,
            child: Column(
              children: [
                Expanded(
                  child: ChatMessagesList(conversationId: conversationId, currentUserId: currentUser.uid),
                ),
                ChatInputField(conversationId: conversationId, currentUserId: currentUser.uid),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:doctor_appointment_app/features/message/data/model/message_model.dart';
import 'package:doctor_appointment_app/features/message/data/services/message_service.dart';
import 'package:doctor_appointment_app/features/message/presentation/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';

class ChatMessagesList extends StatelessWidget {
  const ChatMessagesList({super.key, required this.conversationId, required this.currentUserId});

  final String conversationId;
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MessageModel>>(
      stream: MessageService().getMessages(conversationId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Failed to load messages'));
        }

        final messages = snapshot.data ?? [];

        if (messages.isEmpty) {
          return const Center(
            child: Text(
              'Start the conversation',
              style: TextStyle(fontSize: 15, color: Color(0xFF9CA3AF), fontWeight: FontWeight.w500),
            ),
          );
        }

        return ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          physics: const BouncingScrollPhysics(),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];

            return ChatBubble(isMe: message.senderId == currentUserId, message: message.content);
          },
        );
      },
    );
  }
}

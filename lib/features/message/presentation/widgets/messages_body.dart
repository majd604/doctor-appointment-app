import 'package:doctor_appointment_app/core/loading/list_shimmer.dart';
import 'package:doctor_appointment_app/features/home/data/models/doctor_model.dart';
import 'package:doctor_appointment_app/features/message/bloc/messages_bloc.dart';
import 'package:doctor_appointment_app/features/message/bloc/messages_state.dart';
import 'package:doctor_appointment_app/features/message/presentation/screen/chat_screen.dart';
import 'package:doctor_appointment_app/features/message/presentation/widgets/messages_doctor_card.dart';
import 'package:doctor_appointment_app/features/message/presentation/widgets/messages_message_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MessagesBody extends StatelessWidget {
  const MessagesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesBloc, MessagesState>(
      builder: (context, state) {
        if (state is MessagesLoading || state is MessagesInitial) {
          return ListShimmer(
            height: 88,
            width: MediaQuery.of(context).size.width,
            itemCount: 5,
            scrollDirection: Axis.vertical,
          );
        }

        if (state is MessagesError) {
          return MessagesMessageState(
            icon: Icons.error_outline_rounded,
            title: "Something went wrong",
            subtitle: state.message,
          );
        }

        if (state is MessagesLoaded && state.conversations.isEmpty) {
          return const MessagesMessageState(
            icon: Icons.chat_bubble_outline_rounded,
            title: "No chats yet",
            subtitle: "Start chatting with a doctor and your conversations will appear here.",
          );
        }

        if (state is MessagesLoaded) {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: state.conversations.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final conversation = state.conversations[index];

              return InkWell(
                borderRadius: BorderRadius.circular(22),
                onTap: () {
                  final doctor = DoctorModel(
                    id: conversation.doctorId,
                    name: conversation.doctorName,
                    specialty: '',
                    rating: 0,
                    imageUrl: conversation.doctorImageUrl,
                    about: null,
                    phone: null,
                    callPrice: null,
                    bookingPrice: null,
                    messagePrice: null,
                  );

                  Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(doctor: doctor)));
                },
                child: MessageDoctorCard(
                  name: conversation.doctorName,
                  specialty: 'Tap to open chat',
                  imageUrl: conversation.doctorImageUrl,
                  lastMessage: conversation.lastMessage.isEmpty ? 'Start chatting now' : conversation.lastMessage,
                  time: DateFormat('hh:mm a').format(conversation.lastMessageTime),
                ),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_app/features/message/data/model/conversation_model.dart';
import 'package:doctor_appointment_app/features/message/data/model/message_model.dart';

class MessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String generateConversationId({required String userId, required String doctorId}) {
    return '${userId}_$doctorId';
  }

  Future<String> createOrGetConversation({
    required String userId,
    required String userName,
    required String doctorId,
    required String doctorName,
    required String doctorImageUrl,
  }) async {
    final conversationId = generateConversationId(userId: userId, doctorId: doctorId);

    final conversationRef = _firestore.collection('conversations').doc(conversationId);

    final snapshot = await conversationRef.get();

    if (!snapshot.exists) {
      final conversation = ConversationModel(
        id: conversationId,
        userId: userId,
        userName: userName,
        doctorId: doctorId,
        doctorName: doctorName,
        doctorImageUrl: doctorImageUrl,
        lastMessage: '',
        lastMessageTime: DateTime.now(),
        lastSenderId: '',
        createdAt: DateTime.now(),
      );

      await conversationRef.set(conversation.toJson());
    }

    return conversationId;
  }

  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String senderType,
    required String content,
  }) async {
    final trimmedContent = content.trim();

    if (trimmedContent.isEmpty) return;

    final messageRef = _firestore.collection('conversations').doc(conversationId).collection('messages').doc();

    final message = MessageModel(
      id: messageRef.id,
      senderId: senderId,
      senderType: senderType,
      content: trimmedContent,
      createdAt: DateTime.now(),
      isSeen: false,
    );

    await messageRef.set(message.toJson());

    await _firestore.collection('conversations').doc(conversationId).update({
      'lastMessage': trimmedContent,
      'lastMessageTime': Timestamp.fromDate(DateTime.now()),
      'lastSenderId': senderId,
    });
  }

  Stream<List<MessageModel>> getMessages(String conversationId) {
    return _firestore
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return MessageModel.fromJson(doc.data(), doc.id);
          }).toList();
        });
  }

  Stream<List<ConversationModel>> getUserConversations(String userId) {
    return _firestore
        .collection('conversations')
        .where('userId', isEqualTo: userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return ConversationModel.fromJson(doc.data(), doc.id);
          }).toList();
        });
  }
}

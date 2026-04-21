// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_app/features/auth/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  Future<UserModel?> getCurrentUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return null;
      }
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get(const GetOptions(source: Source.server));
      if (!doc.exists) {
        return null;
      }
      final data = doc.data()!;
      if (data == null) {
        return null;
      }
      return UserModel.fromJson(data, user.uid);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateUserImage({required String imageUrl, required String publicId}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'imageUrl': imageUrl,
        'publicId': publicId,
      });
    } catch (e) {
      throw Exception('Failed to update user image: $e');
    }
  }
}

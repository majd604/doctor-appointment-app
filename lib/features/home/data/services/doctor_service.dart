import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_app/features/home/data/models/doctor_model.dart';
import 'package:flutter/foundation.dart';

class DoctorService {
  Future<List<DoctorModel>> getDoctors() async {
    try {
      final firebase = FirebaseFirestore.instance;
      final snapshot = await firebase.collection('doctors').get();

      return snapshot.docs.map((doc) => DoctorModel.fromJson(doc.data(), doc.id)).toList();
    } catch (e) {
      debugPrint("Error fetching doctors: $e");

      return [];
    }
  }
}

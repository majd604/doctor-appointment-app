// ignore_for_file: unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointment_app/features/appointments/data/model/appointmen_model.dart';

class AppointmentService {
  Future<void> createAppointment(AppointmentModel appointment) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('appointments').add(appointment.toJson());
    } catch (e) {
      throw Exception('Failed to create appointment: $e');
    }
  }

  Future<List<AppointmentModel>> getUserAppointments(String userId) async {
    try {
      final firestore = FirebaseFirestore.instance;

      final querySnapshot = await firestore
          .collection('appointments')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return AppointmentModel.fromJson(data, doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch appointments: $e');
    }
  }

  Future<void> deleteAppointment(String appointmentId) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('appointments').doc(appointmentId).delete();
    } catch (e) {
      throw Exception('Failed to delete appointment: $e');
    }
  }

  Stream<List<AppointmentModel>> getUserAppointmentsStream(String userId) {
    final firestore = FirebaseFirestore.instance;

    return firestore
        .collection('appointments')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return AppointmentModel.fromJson(data, doc.id);
          }).toList();
        });
  }
}

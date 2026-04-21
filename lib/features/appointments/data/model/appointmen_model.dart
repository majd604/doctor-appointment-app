import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String id;
  final String userId;
  final String patientName;
  final String doctorId;
  final String doctorName;
  final String doctorImageUrl;
  final DateTime date;
  final String time;
  final DateTime createdAt;
  final String? doctorSpecialty;
  final String status;
  final String? notes;
  AppointmentModel({
    required this.id,
    required this.userId,
    required this.patientName,
    required this.doctorId,

    required this.doctorName,
    required this.doctorImageUrl,
    required this.date,
    required this.time,
    required this.createdAt,
    this.doctorSpecialty,
    required this.status,
    this.notes,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json, String id) {
    return AppointmentModel(
      id: id,
      userId: json['userId'],
      patientName: json['patientName'],
      doctorId: json['doctorId'],
      doctorName: json['doctorName'],
      doctorImageUrl: json['doctorImageUrl'],
      date: (json['date'] as Timestamp).toDate(),
      time: json['time'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      doctorSpecialty: json['doctorSpecialty'],
      status: json['status'] ?? 'Pending',
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'patientName': patientName,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'doctorImageUrl': doctorImageUrl,
      'date': Timestamp.fromDate(date),
      'time': time,
      'createdAt': Timestamp.fromDate(createdAt),
      'doctorSpecialty': doctorSpecialty,
      'status': status,
      'notes': notes,
    };
  }
}

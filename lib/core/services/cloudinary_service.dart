import 'dart:io';

import 'package:dio/dio.dart';

class CloudinaryService {
  final Dio _dio = Dio();

  Future<Map<String, String>> uploadImage(File file) async {
    try {
      final response = await _dio.post(
        'https://api.cloudinary.com/v1_1/dreuicigr/image/upload',
        data: FormData.fromMap({'file': await MultipartFile.fromFile(file.path), 'upload_preset': 'doctor_app_upload'}),
      );

      final imageUrl = response.data['secure_url'] as String;
      final publicId = response.data['public_id'] as String;

      return {'imageUrl': imageUrl, 'publicId': publicId};
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }
}

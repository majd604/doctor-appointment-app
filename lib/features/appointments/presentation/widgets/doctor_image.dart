import 'package:flutter/material.dart';

class DoctorImage extends StatelessWidget {
  const DoctorImage({super.key, required this.imageUrl, this.height, this.width});

  final String imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Image.network(
        imageUrl,
        height: height ?? 72,
        width: width ?? 72,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          height: height ?? 72,
          width: width ?? 72,
          color: Colors.grey.shade300,
          child: const Icon(Icons.person, color: Colors.grey),
        ),
      ),
    );
  }
}

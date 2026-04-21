// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class MessageDoctorCard extends StatelessWidget {
  const MessageDoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.lastMessage,
    required this.time,
  });

  final String name;
  final String specialty;
  final String imageUrl;
  final String lastMessage;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(
              imageUrl,
              height: 62,
              width: 62,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 62,
                  width: 62,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.person, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
                ),
                const SizedBox(height: 4),
                Text(
                  specialty,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13.5, color: Color(0xFF7C8796), fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            time,
            style: const TextStyle(fontSize: 12.5, color: Color(0xFF9CA3AF), fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

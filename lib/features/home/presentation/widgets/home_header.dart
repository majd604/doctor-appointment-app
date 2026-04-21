// ignore_for_file: deprecated_member_use

import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.username,
    required this.userImageUrl,
    this.userImageCacheKey = '',
  });
  final String username;
  final String userImageUrl;
  final String userImageCacheKey;

  String get _resolvedImageUrl {
    if (userImageUrl.isEmpty || userImageCacheKey.isEmpty) return userImageUrl;

    final uri = Uri.tryParse(userImageUrl);
    if (uri == null) return userImageUrl;

    final nextQuery = Map<String, dynamic>.from(uri.queryParameters);
    nextQuery['v'] = userImageCacheKey;
    return uri.replace(queryParameters: nextQuery.map((key, value) => MapEntry(key, value.toString()))).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello $username",
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
              ),
              const SizedBox(height: 6),
              Text(
                "How are you feeling today?",
                style: TextStyle(fontSize: 16, color: AppColors.subtitleColor, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(color: AppColors.primaryColor.withOpacity(0.12), shape: BoxShape.circle),
          child: userImageUrl.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image.network(
                    _resolvedImageUrl,
                    key: ValueKey(_resolvedImageUrl),
                    fit: BoxFit.cover,
                    width: 70,
                    height: 70,
                    gaplessPlayback: false,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primaryColor),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.person_rounded, color: AppColors.primaryColor, size: 28);
                    },
                  ),
                )
              : const Icon(Icons.person_rounded, color: AppColors.primaryColor, size: 28),
        ),
      ],
    );
  }
}

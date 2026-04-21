// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:doctor_appointment_app/core/services/cloudinary_service.dart';
import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:doctor_appointment_app/features/auth/data/model/services/user_service.dart';
import 'package:doctor_appointment_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:doctor_appointment_app/features/home/presentation/bloc/home_event.dart';
import 'package:doctor_appointment_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:doctor_appointment_app/features/profile/presentation/bloc/profile_event.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileTopSection extends StatefulWidget {
  const ProfileTopSection({super.key, required this.name, required this.email, this.imageUrl, this.publicId});

  final String name;
  final String email;
  final String? imageUrl;
  final String? publicId;

  @override
  State<ProfileTopSection> createState() => _ProfileTopSectionState();
}

class _ProfileTopSectionState extends State<ProfileTopSection> {
  File? selectedImage;
  ImageProvider? imageProvider;
  final ImagePicker picker = ImagePicker();

  // 🔥 chose pic
  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return;

    final file = File(picked.path);

    setState(() {
      selectedImage = file;
    });

    try {
      final result = await CloudinaryService().uploadImage(file);

      final imageUrl = result['imageUrl'];
      final publicId = result['publicId'];

      await UserService().updateUserImage(imageUrl: imageUrl!, publicId: publicId!);
      if (mounted) {
        context.read<HomeBloc>().add(LoadHomeData());
        context.read<ProfileBloc>().add(LoadProfileData());
      }
    } catch (e) {
      debugPrint("Upload failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const LinearGradient(
                  colors: [Color(0xFF0B7A75), Color(0xFF139A94)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.22),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  color: Colors.white,
                  child: selectedImage != null
                      ? Image.file(selectedImage!, fit: BoxFit.cover, width: double.infinity, height: double.infinity)
                      : (widget.imageUrl != null && widget.imageUrl!.isNotEmpty)
                      ? Image.network(
                          widget.imageUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(child: Icon(Icons.person, size: 52, color: Colors.grey));
                          },
                        )
                      : const Center(child: Icon(Icons.person, size: 52, color: Colors.grey)),
                ),
              ),
            ),

            Positioned(
              bottom: -4,
              right: -4,
              child: GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 8, offset: const Offset(0, 3)),
                    ],
                  ),
                  child: const Icon(Icons.camera_alt_rounded, size: 18, color: AppColors.primaryColor),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        Text(
          widget.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1F2937),
            letterSpacing: 0.2,
          ),
        ),

        const SizedBox(height: 8),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: Text(
            widget.email,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF6B7280), fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

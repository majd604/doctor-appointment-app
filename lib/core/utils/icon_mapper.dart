import 'package:flutter/material.dart';

class IconMapper {
  static IconData getIcon(String iconName) {
    final iconsMap = {
      "heart": Icons.favorite_outline,
      "tooth": Icons.medical_services_outlined,
      "brain": Icons.psychology_outlined,
      "bone": Icons.accessibility_new_outlined,
      "child": Icons.child_care_outlined,
      "eye": Icons.visibility_outlined,
    };

    return iconsMap[iconName.toLowerCase()] ?? Icons.category_outlined;
  }
}

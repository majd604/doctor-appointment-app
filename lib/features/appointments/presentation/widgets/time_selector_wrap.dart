import 'package:doctor_appointment_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TimeSelectorWrap extends StatelessWidget {
  const TimeSelectorWrap({
    super.key,
    required this.availableTimes,
    required this.selectedTime,
    required this.onTimeSelected,
  });

  final List<String> availableTimes;
  final String? selectedTime;
  final ValueChanged<String> onTimeSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: availableTimes.map((time) {
        final isSelected = selectedTime == time;

        return GestureDetector(
          onTap: () => onTimeSelected(time),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: isSelected ? AppColors.primaryColor : Colors.grey.shade300),
            ),
            child: Text(
              time,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF4B5563),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

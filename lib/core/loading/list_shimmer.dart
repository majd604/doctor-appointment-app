import 'package:doctor_appointment_app/core/loading/loadind_shimmer.dart';
import 'package:flutter/material.dart';

class ListShimmer extends StatelessWidget {
  const ListShimmer({
    super.key,
    required this.height,
    required this.width,
    required this.itemCount,
    required this.scrollDirection,
  });
  final double height;
  final double width;
  final int itemCount;
  final Axis scrollDirection;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: scrollDirection,
      physics: const NeverScrollableScrollPhysics(),

      shrinkWrap: true,
      itemCount: itemCount,
      separatorBuilder: (context, index) =>
          scrollDirection == Axis.horizontal ? const SizedBox(width: 40) : const SizedBox(height: 16),
      itemBuilder: (context, index) => LoadindShimmer(height: height, width: width),
    );
  }
}

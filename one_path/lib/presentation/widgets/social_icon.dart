import 'package:flutter/material.dart';
import 'package:one_path/core/constants/app_colors.dart';

class SocialIcon extends StatelessWidget {
  final String assetPath;

  const SocialIcon({required this.assetPath, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          color: AppColors.white20,

          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.white20, width: 1),
        ),
        child: Center(
          child: Image.asset(
            assetPath,
            width: 22,
            height: 22,
            fit: BoxFit.contain,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}

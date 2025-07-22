import 'package:flutter/material.dart';
import 'package:one_path/core/constants/app_colors.dart';
import 'package:one_path/core/constants/image_paths.dart';
import 'package:one_path/core/constants/text_styles.dart';
import 'package:one_path/localizations/app_localizations.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const CustomBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => onTabChange(0),
            child: Container(
              width: 140,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.white20, width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImagePaths.home,
                    width: 30,
                    height: 30,
                    color: AppColors.white,
                    colorBlendMode: BlendMode.srcIn,
                  ),
                  const SizedBox(width: 8),
                  Text(AppLocalizations.of(context).homePage,
                      style: AppTextStyles.medium12White),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onTabChange(1),
            child: Container(
              width: 140,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.white20, width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImagePaths.profile,
                    width: 30,
                    height: 30,
                    color: AppColors.white,
                    colorBlendMode: BlendMode.srcIn,
                  ),
                  const SizedBox(width: 8),
                  Text(AppLocalizations.of(context).profile,
                      style: AppTextStyles.medium12White),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

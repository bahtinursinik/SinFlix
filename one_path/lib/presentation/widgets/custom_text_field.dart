import 'package:flutter/material.dart';
import 'package:one_path/core/constants/app_colors.dart';
import 'package:one_path/core/constants/image_paths.dart';
import 'package:one_path/core/constants/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String prefixImagePath;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixImagePath,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? obscureText : false,
      style: TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white10,
        hintText: hintText,
        hintStyle: AppTextStyles.regular12White50,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            prefixImagePath,
            width: 20,
            height: 20,
            color: AppColors.white,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: AppColors.white20, width: 1),
        ),
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Image.asset(
                    ImagePaths.hide,
                    width: 20,
                    height: 20,
                    color: AppColors.white,
                  ),
                  onPressed: onToggleVisibility,
                )
                : null,
      ),
    );
  }
}

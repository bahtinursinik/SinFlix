import 'package:flutter/material.dart';
import 'package:one_path/core/constants/app_colors.dart';
import 'package:one_path/core/constants/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback onTap;
  final double? verticalPadding;
  final double? fontSize;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double borderRadius;

  const CustomButton({
    super.key,
    this.text,
    this.child,
    required this.onTap,
    this.verticalPadding = 18,
    this.fontSize = 15,
    this.backgroundColor = AppColors.red,
    this.textColor = AppColors.white,
    this.width,
    this.height,
    this.borderRadius = 18,
  }) : assert(
          text != null || child != null,
          'Either text or child must be provided',
        );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(vertical: verticalPadding!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: Center(
          child: child ??
              Text(
                text!,
                style: AppTextStyles.medium15White.copyWith(
                  fontSize: fontSize,
                  color: textColor,
                ),
              ),
        ),
      ),
    );
  }
}

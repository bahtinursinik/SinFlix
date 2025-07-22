import 'package:flutter/material.dart';
import 'package:one_path/core/constants/app_colors.dart';

class InnerShadowCircle extends StatelessWidget {
  final Widget child;

  const InnerShadowCircle({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 65,
      height: 65,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipOval(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.darkRed,
              ),
              child: Center(child: child),
            ),
          ),
          ClipOval(
            child: CustomPaint(
              painter: _InnerShadowPainter(),
            ),
          ),
          ClipOval(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.white10, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InnerShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double blur = 8;
    const double strokeWidth = 4;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..maskFilter = const MaskFilter.blur(BlurStyle.inner, blur)
      ..color = AppColors.white;

    final Rect rect = Offset.zero & size;
    final Path circle = Path()..addOval(rect.deflate(strokeWidth / 2));

    canvas.drawPath(circle, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

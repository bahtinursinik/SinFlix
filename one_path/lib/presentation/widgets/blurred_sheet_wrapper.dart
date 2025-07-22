// import 'dart:ui';

// import 'package:flutter/material.dart';

// class BlurredSheetWrapper extends StatelessWidget {
//   final Widget child;

//   const BlurredSheetWrapper({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Theme.of(context).cardColor.withValues(alpha: 0.85),
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//           ),
//           padding: const EdgeInsets.all(20),
//           child: child,
//         ),
//       ),
//     );
//   }
// }

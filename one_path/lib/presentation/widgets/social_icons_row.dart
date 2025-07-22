import 'package:flutter/material.dart';
import 'package:one_path/core/constants/image_paths.dart';

import 'social_icon.dart';

class SocialIconsRow extends StatelessWidget {
  const SocialIconsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SocialIcon(assetPath: ImagePaths.google),
        SocialIcon(assetPath: ImagePaths.apple),
        SocialIcon(assetPath: ImagePaths.facebook),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:one_path/core/constants/image_paths.dart';
import 'package:one_path/core/services/token_service.dart';

import '../../core/services/navigation_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = await TokenStorage.getToken();

    if (token != null && token.isNotEmpty) {
      NavigationService.clearAndPush('/main');
    } else {
      NavigationService.clearAndPush('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(ImagePaths.splash, fit: BoxFit.cover),
      ),
    );
  }
}

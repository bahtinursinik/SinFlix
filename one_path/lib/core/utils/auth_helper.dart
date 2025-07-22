import 'package:flutter/material.dart';
import 'package:one_path/core/services/navigation_service.dart';
import 'package:one_path/core/services/token_service.dart';

class AuthHelper {
  static Future<void> logout(BuildContext context) async {
    await TokenStorage.deleteToken();
    await TokenStorage.deleteAll();

    NavigationService.clearAndPush('/login');
  }
}

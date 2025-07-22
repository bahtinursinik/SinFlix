import 'package:flutter/foundation.dart';

class LoggerService {
  static void logInfo(String message) {
    if (kDebugMode) {
      print('INFO: $message');
    }
  }

  static void logWarning(String message) {
    if (kDebugMode) {
      print('WARNING: $message');
    }
  }

  static void logError(String message, [dynamic error]) {
    if (kDebugMode) {
      print(' ERROR: $message');
      if (error != null) print('🔍 Detail: $error');
    }
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LanguageStorage {
  static final _storage = FlutterSecureStorage();
  static const _keyLanguage = 'app_language';

  static Future<void> saveLanguage(String languageCode) async {
    await _storage.write(key: _keyLanguage, value: languageCode);
  }

  static Future<String?> getLanguage() async {
    return await _storage.read(key: _keyLanguage);
  }

  static Future<void> deleteLanguage() async {
    await _storage.delete(key: _keyLanguage);
  }
}

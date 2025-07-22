import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:one_path/data/models/user_model.dart';

class TokenStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyToken = 'auth_token';
  static const _keyUser = 'auth_user';

  static IOSOptions _getIOSOptions() =>
      IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  // Token kaydet - sadece write
  static Future<void> saveToken(String token) async {
    int retry = 0;
    while (retry < 2) {
      try {
        await _storage.write(
            key: _keyToken, value: token, iOptions: _getIOSOptions());
        break;
      } catch (e) {
        if (e.toString().contains('The specified item already exists')) {
          await Future.delayed(Duration(milliseconds: 100));
          retry++;
        } else {
          rethrow;
        }
      }
    }
  }

  // Token oku
  static Future<String?> getToken() async {
    return await _storage.read(
      key: _keyToken,
      iOptions: _getIOSOptions(),
    );
  }

  // Token sil
  static Future<void> deleteToken() async {
    await _storage.delete(
      key: _keyToken,
      iOptions: _getIOSOptions(),
    );
  }

  // User kaydet - sadece write kullanıyoruz (update eder)
  static Future<void> saveUser(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    int retry = 0;
    while (retry < 2) {
      try {
        await _storage.write(
            key: _keyUser, value: userJson, iOptions: _getIOSOptions());
        break;
      } catch (e) {
        if (e.toString().contains('The specified item already exists')) {
          await Future.delayed(Duration(milliseconds: 100));
          retry++;
        } else {
          rethrow;
        }
      }
    }
  }

  static Future<UserModel?> getUser() async {
    final userJson = await _storage.read(
      key: _keyUser,
      iOptions: _getIOSOptions(),
    );

    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  static Future<void> deleteAll() async {
    await _storage.deleteAll(iOptions: _getIOSOptions());
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:one_path/core/services/logger_service.dart';
import 'package:one_path/data/models/user_model.dart';
import 'package:one_path/presentation/blocs/register/register_state.dart';

class AuthResponse {
  final String token;
  final UserModel user;

  AuthResponse({required this.token, required this.user});
}

class AuthRepository {
  final String baseUrl = 'https://caseapi.servicelabs.tech';

  Future<AuthResponse> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/user/login');
    LoggerService.logInfo('Login işlemi başlatılıyor: $email');

    final response = await http.post(
      url,
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    LoggerService.logInfo('Login yanıt alındı: ${response.statusCode}');

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final data = decoded['data'];
      final token = data['token'];
      final user = UserModel.fromJson(data);
      LoggerService.logInfo('Login başarılı. Token alındı.');
      return AuthResponse(token: token, user: user);
    } else if (response.statusCode == 400) {
      LoggerService.logWarning('Geçersiz giriş bilgileri');
      throw ('Geçersiz giriş bilgileri');
    } else {
      LoggerService.logError(
        'Login hatası',
        'Status code: ${response.statusCode}',
      );
      throw Exception('Login failed (${response.statusCode})');
    }
  }

  Future<void> register(String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/user/register');
    LoggerService.logInfo('Register işlemi başlatılıyor: $email');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'name': name, 'password': password}),
    );

    LoggerService.logInfo('Register yanıt alındı: ${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      LoggerService.logInfo('Kayıt başarılı');
      return;
    } else if (response.statusCode == 400) {
      final body = jsonDecode(response.body);
      final message = body['response']?['message'];
      LoggerService.logWarning('Kayıt sırasında hata oluştu: $message');

      if (message == 'INVALID_EMAIL_FORMAT') {
        throw RegisterException('Geçersiz e-posta');
      } else if (message == 'EMAIL_ALREADY_EXISTS') {
        throw RegisterException('Bu e-posta adresi zaten kayıtlı');
      } else if (message == 'USERNAME_LENGTH_INVALID') {
        throw RegisterException('İsim geçersiz. Lütfen geçerli bir isim girin');
      } else {
        throw RegisterException('Geçersiz giriş bilgileri');
      }
    } else {
      LoggerService.logError(
        'Kayıt başarısız',
        'Status code: ${response.statusCode}',
      );
      throw RegisterException('Kayıt başarısız oldu (${response.statusCode})');
    }
  }

  Future<String> uploadPhoto(String token, String filePath) async {
    final url = Uri.parse('$baseUrl/user/upload_photo');
    LoggerService.logInfo('Fotoğraf yükleme başlatılıyor: $filePath');

    var request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    LoggerService.logInfo('Upload yanıt alındı: ${response.statusCode}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final photoUrl = data['data']['photoUrl'] ?? '';
      LoggerService.logInfo('Fotoğraf başarıyla yüklendi: $photoUrl');
      return photoUrl;
    } else if (response.statusCode == 400) {
      LoggerService.logWarning('Geçersiz dosya formatı');
      throw Exception('Invalid file format');
    } else if (response.statusCode == 401) {
      LoggerService.logWarning('Yetkisiz erişim');
      throw Exception('Unauthorized');
    } else {
      LoggerService.logError(
        'Fotoğraf yükleme başarısız',
        'Status code: ${response.statusCode}',
      );
      throw Exception('Upload failed with status ${response.statusCode}');
    }
  }

  Future<UserModel> fetchProfile(String token) async {
    final url = Uri.parse('$baseUrl/user/profile');
    LoggerService.logInfo('Profil verisi çekiliyor');

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    LoggerService.logInfo('Profil yanıt alındı: ${response.statusCode}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final userData = jsonResponse['data'];
      LoggerService.logInfo('Profil başarıyla alındı');
      return UserModel.fromJson(userData);
    } else {
      LoggerService.logError(
        'Profil yükleme başarısız',
        'Status code: ${response.statusCode}',
      );
      throw Exception('Failed to load profile');
    }
  }
}

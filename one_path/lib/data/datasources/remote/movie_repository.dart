import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:one_path/core/services/logger_service.dart';
import 'package:one_path/data/models/movie_model.dart';

class MovieRepository {
  final String baseUrl = "https://caseapi.servicelabs.tech";

  Future<void> toggleFavorite(String token, String movieId) async {
    final url = Uri.parse('$baseUrl/movie/favorite/$movieId');

    LoggerService.logInfo('Favori durumu değiştiriliyor: $url');

    try {
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      LoggerService.logInfo('Favori yanıt durumu: ${response.statusCode}');

      if (response.statusCode != 200) {
        final message =
            jsonDecode(response.body)['message'] ?? 'Favori işlemi başarısız.';
        LoggerService.logWarning('Favori işlemi başarısız: $message');
        throw Exception(message);
      }

      LoggerService.logInfo('Favori işlemi başarılı.');
    } catch (e) {
      LoggerService.logError('toggleFavorite() hatası', e);
      rethrow;
    }
  }

  Future<List<MovieModel>> fetchAllMovies(String token, {int page = 1}) async {
    final url = Uri.parse('$baseUrl/movie/list?page=$page');

    LoggerService.logInfo('Tüm filmler çekiliyor: $url');

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      LoggerService.logInfo(
        'Film listesi yanıt durumu: ${response.statusCode}',
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List movies = data['data']['movies'];

        LoggerService.logInfo('Film sayısı: ${movies.length}');
        return movies.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        LoggerService.logWarning('Film listesi alınamadı');
        throw Exception('Film listesi alınamadı');
      }
    } catch (e) {
      LoggerService.logError('fetchAllMovies() hatası', e);
      rethrow;
    }
  }

  Future<int> fetchTotalPages(String token) async {
    final url = Uri.parse('$baseUrl/movie/list?page=1');

    LoggerService.logInfo('Toplam sayfa sayısı çekiliyor: $url');

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      LoggerService.logInfo(
        'Toplam sayfa yanıt durumu: ${response.statusCode}',
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final totalPages = data['totalPages'] ?? 1;

        LoggerService.logInfo('Toplam sayfa sayısı: $totalPages');
        return totalPages;
      } else {
        LoggerService.logWarning('Sayfa bilgisi alınamadı');
        throw Exception('Sayfa bilgisi alınamadı');
      }
    } catch (e) {
      LoggerService.logError('fetchTotalPages() hatası', e);
      rethrow;
    }
  }

  Future<List<MovieModel>> fetchFavoriteMovies(String token) async {
    final url = Uri.parse('$baseUrl/movie/favorites');

    LoggerService.logInfo('Favori filmler çekiliyor: $url');

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      LoggerService.logInfo('Favori film yanıt durumu: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List moviesJson = data['data'];

        LoggerService.logInfo('Favori film sayısı: ${moviesJson.length}');
        return moviesJson.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        LoggerService.logWarning(
          'Favori filmler yüklenemedi (${response.statusCode})',
        );
        throw Exception("Favori filmler yüklenemedi (${response.statusCode})");
      }
    } catch (e) {
      LoggerService.logError('fetchFavoriteMovies() hatası', e);
      rethrow;
    }
  }
}

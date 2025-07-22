class MovieModel {
  final String id;
  final String title;
  final String description;
  final String posterUrl;
  final String director;

  final bool isFavorite;

  MovieModel({
    required this.id,
    required this.title,
    required this.description,
    required this.posterUrl,
    required this.director,

    this.isFavorite = false,
  });

  static String cleanPosterUrl(String url) {
    if (url.isEmpty) return url;

    url = url.replaceAll('..jpg', '.jpg');
    url = url.replaceAll('@@..jpg', '@@.jpg');

    if (url.startsWith('http://')) {
      url = url.replaceFirst('http://', 'https://');
    }

    return url;
  }

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? '',
      title: json['Title'] ?? '',
      description: json['Plot'] ?? '',
      posterUrl: cleanPosterUrl(json['Poster'] ?? ''),
      isFavorite: json['isFavorite'] ?? false,
      director: json['Director'] ?? '',
    );
  }
}

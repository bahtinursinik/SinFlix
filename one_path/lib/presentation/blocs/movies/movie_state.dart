import 'package:one_path/data/models/movie_model.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<MovieModel> movies;
  final int currentPage;
  final bool hasReachedMax;

  MovieLoaded({
    required this.movies,
    required this.currentPage,
    required this.hasReachedMax,
  });

  MovieLoaded copyWith({
    List<MovieModel>? movies,
    int? currentPage,
    bool? hasReachedMax,
  }) {
    return MovieLoaded(
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class MovieFailure extends MovieState {
  final String message;
  MovieFailure(this.message);
}

// import 'package:one_path/data/models/movie_model.dart';

// abstract class FavoriteMovieState {}

// class FavoriteMovieInitial extends FavoriteMovieState {}

// class FavoriteMovieLoading extends FavoriteMovieState {}

// class FavoriteMovieSuccess extends FavoriteMovieState {}

// class FavoriteMovieFailure extends FavoriteMovieState {
//   final String message;
//   FavoriteMovieFailure(this.message);
// }

// class FavoriteMovieLoaded extends FavoriteMovieState {
//   final List<MovieModel> movies;

//   FavoriteMovieLoaded(this.movies);
// }
import 'package:one_path/data/models/movie_model.dart';

abstract class FavoriteMovieState {}

class FavoriteMovieInitial extends FavoriteMovieState {}

class FavoriteMovieLoading extends FavoriteMovieState {}

class FavoriteMovieSuccess extends FavoriteMovieState {
  final List<String> favoriteMovieIds;
  FavoriteMovieSuccess(this.favoriteMovieIds);
}

class FavoriteMovieFailure extends FavoriteMovieState {
  final String message;
  FavoriteMovieFailure(this.message);
}

class FavoriteMovieLoaded extends FavoriteMovieState {
  final List<MovieModel> movies;
  FavoriteMovieLoaded(this.movies);
}

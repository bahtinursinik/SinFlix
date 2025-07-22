abstract class FavoriteMovieEvent {}

class ToggleFavoriteMovie extends FavoriteMovieEvent {
  final String movieId;

  ToggleFavoriteMovie(this.movieId);
}

class FetchFavoriteMovies extends FavoriteMovieEvent {}

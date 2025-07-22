abstract class MovieEvent {}

class FetchAllMovies extends MovieEvent {
  final int page;

  FetchAllMovies({this.page = 1});
}

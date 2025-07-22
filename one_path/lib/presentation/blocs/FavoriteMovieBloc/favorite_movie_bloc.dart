import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_path/core/services/token_service.dart';
import 'package:one_path/data/datasources/remote/movie_repository.dart';

import 'favorite_movie_event.dart';
import 'favorite_movie_state.dart';

class FavoriteMovieBloc extends Bloc<FavoriteMovieEvent, FavoriteMovieState> {
  final MovieRepository movieRepository;

  FavoriteMovieBloc({required this.movieRepository})
      : super(FavoriteMovieInitial()) {
    on<ToggleFavoriteMovie>((event, emit) async {
      emit(FavoriteMovieLoading());
      try {
        final token = await TokenStorage.getToken();
        if (token == null) throw Exception("Token bulunamadı");

        await movieRepository.toggleFavorite(token, event.movieId);

        // Favori filmleri tekrar çek
        final favoriteMovies = await movieRepository.fetchFavoriteMovies(token);
        final favoriteIds = favoriteMovies.map((m) => m.id).toList();

        emit(FavoriteMovieSuccess(favoriteIds));
      } catch (e) {
        emit(FavoriteMovieFailure(e.toString()));
      }
    });

    // 🔹 Favori film listesini getirme
    on<FetchFavoriteMovies>((event, emit) async {
      emit(FavoriteMovieLoading());
      try {
        final token = await TokenStorage.getToken();
        if (token == null) throw Exception("Token bulunamadı");

        final movies = await movieRepository.fetchFavoriteMovies(token);
        emit(FavoriteMovieLoaded(movies));
      } catch (e) {
        emit(FavoriteMovieFailure(e.toString()));
      }
    });
  }
}

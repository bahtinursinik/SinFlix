import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_path/core/services/logger_service.dart';
import 'package:one_path/core/services/token_service.dart';
import 'package:one_path/data/datasources/remote/movie_repository.dart';
import 'package:one_path/data/models/movie_model.dart';
import 'package:one_path/presentation/blocs/movies/movie_event.dart';
import 'package:one_path/presentation/blocs/movies/movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc({required this.movieRepository}) : super(MovieInitial()) {
    on<FetchAllMovies>((event, emit) async {
      LoggerService.logInfo(
        'FetchAllMovies event triggered with page=${event.page}',
      );

      final currentState = state;

      try {
        if (currentState is MovieLoaded && currentState.hasReachedMax) {
          LoggerService.logInfo(
            'Zaten son sayfaya ulaşıldı, daha fazla yüklenmeyecek.',
          );
          return;
        }

        List<MovieModel> oldMovies = [];
        int nextPage = 1;

        if (currentState is MovieLoaded) {
          oldMovies = currentState.movies;
          nextPage = currentState.currentPage + 1;
          LoggerService.logInfo(
            'Mevcut film sayısı: ${oldMovies.length}, sonraki sayfa: $nextPage',
          );
        } else {
          LoggerService.logInfo(
            'İlk sayfa yükleniyor, loading state emit ediliyor.',
          );
          emit(MovieLoading());
        }

        final token = await TokenStorage.getToken();
        if (token == null) {
          LoggerService.logWarning('Token bulunamadı, işlem iptal edildi.');
          throw Exception("Token bulunamadı");
        }
        LoggerService.logInfo('Token alındı, filmler API çağrısı yapılıyor.');

        final movies = await movieRepository.fetchAllMovies(
          token,
          page: nextPage,
        );

        LoggerService.logInfo('API çağrısından ${movies.length} film döndü.');

        final bool hasReachedMax = movies.isEmpty;

        final allMovies = [...oldMovies, ...movies];

        LoggerService.logInfo(
          'Toplam film sayısı: ${allMovies.length}, hasReachedMax: $hasReachedMax',
        );

        emit(
          MovieLoaded(
            movies: allMovies,
            currentPage: nextPage,
            hasReachedMax: hasReachedMax,
          ),
        );
      } catch (e) {
        LoggerService.logError('FetchAllMovies sırasında hata oluştu', e);
        emit(MovieFailure(e.toString()));
      }
    });
  }
}

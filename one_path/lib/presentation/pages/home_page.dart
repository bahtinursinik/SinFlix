import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:one_path/core/constants/app_colors.dart';
import 'package:one_path/core/constants/image_paths.dart';
import 'package:one_path/core/constants/text_styles.dart';
import 'package:one_path/data/models/movie_model.dart';
import 'package:one_path/localizations/app_localizations.dart';
import 'package:one_path/presentation/blocs/FavoriteMovieBloc/favorite_movie_bloc.dart';
import 'package:one_path/presentation/blocs/FavoriteMovieBloc/favorite_movie_event.dart';
import 'package:one_path/presentation/blocs/FavoriteMovieBloc/favorite_movie_state.dart';
import 'package:one_path/presentation/blocs/movies/movie_bloc.dart';
import 'package:one_path/presentation/blocs/movies/movie_event.dart';
import 'package:one_path/presentation/blocs/movies/movie_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(FetchAllMovies(page: 1));
    context.read<FavoriteMovieBloc>().add(FetchFavoriteMovies());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        final state = context.read<MovieBloc>().state;
        if (state is MovieLoaded && !state.hasReachedMax) {
          context.read<MovieBloc>().add(
                FetchAllMovies(page: state.currentPage + 1),
              );
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<FavoriteMovieBloc, FavoriteMovieState>(
            listener: (context, state) {
              if (state is FavoriteMovieSuccess) {
                // Favori değiştiğinde listeyi yenile
                context.read<MovieBloc>().add(FetchAllMovies(page: 1));
              } else if (state is FavoriteMovieFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Hata: ${state.message}")),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieLoaded) {
              final movies = state.movies;

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<MovieBloc>().add(FetchAllMovies(page: 1));

                  await context.read<MovieBloc>().stream.firstWhere(
                        (state) => state is! MovieLoading,
                      );
                },
                child: ListView.separated(
                  controller: _scrollController,
                  itemCount: movies.length + (state.hasReachedMax ? 0 : 1),
                  itemBuilder: (context, index) {
                    if (index == movies.length) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final movie = movies[index];
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: MovieCardFullScreen(movie: movie),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                ),
              );
            } else if (state is MovieFailure) {
              return Center(child: Text("Hata: ${state.message}"));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

class MovieCardFullScreen extends StatefulWidget {
  final MovieModel movie;

  const MovieCardFullScreen({super.key, required this.movie});

  @override
  State<MovieCardFullScreen> createState() => _MovieCardFullScreenState();
}

class _MovieCardFullScreenState extends State<MovieCardFullScreen> {
  bool showFullDescription = false;
  bool showLikeAnimation = false;

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            movie.posterUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Center(
              child: Icon(Icons.image, size: 100, color: Colors.grey),
            ),
          ),
        ),
        if (showLikeAnimation)
          Center(
            child: Lottie.asset(
              ImagePaths.fav,
              width: 250,
              height: MediaQuery.of(context).size.height / 2,
              repeat: false,
              onLoaded: (composition) {
                Future.delayed(composition.duration, () {
                  if (mounted) {
                    setState(() {
                      showLikeAnimation = false;
                    });
                  }
                });
              },
            ),
          ),
        Positioned(
          right: 16,
          bottom: 110,
          child: BlocBuilder<FavoriteMovieBloc, FavoriteMovieState>(
            builder: (context, state) {
              bool isFavorite = false;
              if (state is FavoriteMovieSuccess) {
                isFavorite = state.favoriteMovieIds.contains(movie.id);
              } else if (state is FavoriteMovieLoaded) {
                isFavorite = state.movies.any((m) => m.id == movie.id);
              } else {
                isFavorite = movie.isFavorite;
              }

              return GestureDetector(
                onTap: () {
                  context.read<FavoriteMovieBloc>().add(
                        ToggleFavoriteMovie(movie.id),
                      );

                  setState(() {
                    showLikeAnimation = true;
                  });
                },
                child: Container(
                  width: 49.18,
                  height: 71.7,
                  decoration: BoxDecoration(
                    color: AppColors.white10,
                    border: Border.all(
                      color: AppColors.white20,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Image.asset(
                      ImagePaths.heart,
                      width: 26,
                      height: 26,
                      color: isFavorite ? AppColors.red : AppColors.white,
                      colorBlendMode: BlendMode.srcIn,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withAlpha(230),
                  Colors.black.withAlpha(128),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: AppTextStyles.semiBold18WhiteCentered),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showFullDescription = !showFullDescription;
                    });
                  },
                  child: RichText(
                    text: TextSpan(
                      text: showFullDescription
                          ? movie.description
                          : movie.description.length > 100
                              ? '${movie.description.substring(0, 100)}... '
                              : movie.description,
                      style: AppTextStyles.regular13White75,
                      children: [
                        if (movie.description.length > 100)
                          TextSpan(
                            text: showFullDescription
                                ? AppLocalizations.of(context).showLess
                                : AppLocalizations.of(context).showMore,
                            style: AppTextStyles.bold13White,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

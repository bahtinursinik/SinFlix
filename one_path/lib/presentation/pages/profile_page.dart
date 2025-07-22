import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_path/core/constants/app_colors.dart';
import 'package:one_path/core/constants/image_paths.dart';
import 'package:one_path/core/constants/text_styles.dart';
import 'package:one_path/core/services/navigation_service.dart';
import 'package:one_path/core/services/token_service.dart';
import 'package:one_path/localizations/app_localizations.dart';
import 'package:one_path/presentation/blocs/FavoriteMovieBloc/favorite_movie_bloc.dart';
import 'package:one_path/presentation/blocs/FavoriteMovieBloc/favorite_movie_event.dart';
import 'package:one_path/presentation/blocs/FavoriteMovieBloc/favorite_movie_state.dart';
import 'package:one_path/presentation/blocs/profile/profile_bloc.dart';
import 'package:one_path/presentation/blocs/profile/profile_event.dart';
import 'package:one_path/presentation/blocs/profile/profile_state.dart';
import 'package:one_path/presentation/routes/app_routes.dart';
import 'package:one_path/presentation/widgets/custom_bottom_sheet_widget.dart';
import 'package:one_path/presentation/widgets/custom_button.dart';
import 'package:one_path/presentation/widgets/settings_bottom_sheet.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String token;

  @override
  void initState() {
    super.initState();
    _loadTokenAndProfile();
  }

  Future<void> _loadTokenAndProfile() async {
    token = (await TokenStorage.getToken()) ?? '';
    if (token.isNotEmpty) {
      if (mounted) {
        context.read<ProfileBloc>().add(ProfileRequested(token));
      }
    }
  }

  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (_) {
        return Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * 0.001,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  color: Color.lerp(Colors.red, Colors.white, 0.5)!
                      .withValues(alpha: 0.15),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: const JetonBottomSheet(),
            ),
          ],
        );
      },
    );
  }

  void _showSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      barrierColor: AppColors.white20,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => const SettingsBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<FavoriteMovieBloc>().add(FetchFavoriteMovies());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).profileDetail,
          style: AppTextStyles.medium18White,
        ),
        backgroundColor: AppColors.black,
        leading: IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () => _showSettingsBottomSheet(context),
        ),
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 3.5,
            child: CustomButton(
              onTap: () {
                _showCustomBottomSheet(context);
              },
              verticalPadding: 0,
              borderRadius: 20,
              height: 40,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 15,
                    height: 15,
                    child: Image.asset(ImagePaths.diamond),
                  ),
                  const SizedBox(width: 8),
                  Text(AppLocalizations.of(context).limitedOffer,
                      style: AppTextStyles.semiBold12White),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '${AppLocalizations.of(context).profileLoadErrorMessage} ${state.error}'),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProfileLoaded) {
                  final user = state.user;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.white50,
                        backgroundImage: (user.photoUrl.isNotEmpty)
                            ? NetworkImage(
                                '${user.photoUrl}?v=${DateTime.now().millisecondsSinceEpoch}',
                              )
                            : null,
                        child: (user.photoUrl.isEmpty)
                            ? const Icon(Icons.person, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.name, style: AppTextStyles.medium15White),
                            const SizedBox(height: 4),
                            Text(
                              "ID: ${user.id}",
                              style: AppTextStyles.regular12White,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.5,
                        child: CustomButton(
                          text: AppLocalizations.of(context).addPhoto,
                          onTap: () async {
                            final result = await NavigationService.navigateTo(
                              AppRoutes.uploadPhoto,
                              arguments: {'fromProfile': true},
                            );
                            if (!context.mounted) return;
                            if (result == true) {
                              context.read<ProfileBloc>().add(
                                    ProfileRequested(token),
                                  );
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      AppLocalizations.of(context)
                                          .photoAddSuccess,
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            }
                          },
                          fontSize: 13,
                          verticalPadding: 10,
                          borderRadius: 6,
                        ),
                      ),
                    ],
                  );
                } else if (state is ProfileFailure) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context).profileLoadError,
                      style: AppTextStyles.regular12White50,
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(height: 30),
            Text(AppLocalizations.of(context).favoriteMovies,
                style: AppTextStyles.bold13White),
            const SizedBox(height: 30),
            Expanded(
              child: BlocBuilder<FavoriteMovieBloc, FavoriteMovieState>(
                builder: (context, state) {
                  if (state is FavoriteMovieLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FavoriteMovieFailure) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: AppColors.red),
                      ),
                    );
                  } else if (state is FavoriteMovieLoaded) {
                    final movies = state.movies;
                    if (movies.isEmpty) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context).favoriteMoviesEmpty,
                          style: AppTextStyles.regular12White50,
                        ),
                      );
                    }
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                movie.posterUrl,
                                height: 220,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              movie.title,
                              style: AppTextStyles.medium12White,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              movie.director,
                              style: AppTextStyles.regular12White50,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

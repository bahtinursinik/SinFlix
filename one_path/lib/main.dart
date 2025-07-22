import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:one_path/core/services/localization_service.dart';
import 'package:one_path/data/datasources/remote/auth_repository.dart';
import 'package:one_path/data/datasources/remote/movie_repository.dart';
import 'package:one_path/localizations/app_localizations.dart';
import 'package:one_path/presentation/blocs/AppBlocObserver/app_bloc_observer.dart';
import 'package:one_path/presentation/blocs/FavoriteMovieBloc/favorite_movie_bloc.dart';
import 'package:one_path/presentation/blocs/locale/locale_cubit.dart';
import 'package:one_path/presentation/blocs/movies/movie_bloc.dart';
import 'package:one_path/presentation/blocs/profile/profile_bloc.dart';
import 'package:one_path/presentation/blocs/upload-photo/upload_photo_bloc.dart';
import 'package:one_path/presentation/pages/home_page.dart';
import 'package:one_path/presentation/pages/main_page.dart';
import 'package:one_path/presentation/pages/profile_page.dart';

import 'core/services/navigation_service.dart';
import 'presentation/blocs/login/login_bloc.dart';
import 'presentation/blocs/register/register_bloc.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/register_page.dart';
import 'presentation/pages/splash_screen_page.dart';
import 'presentation/pages/upload_photo_page.dart';
import 'presentation/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedLanguageCode = await LanguageStorage.getLanguage();
  Bloc.observer = AppBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(
          create: (_) => LocaleCubit(
            initialLocale: savedLanguageCode != null
                ? Locale(savedLanguageCode)
                : const Locale('en'),
          ),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(authRepository: AuthRepository()),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(authRepository: AuthRepository()),
        ),
        BlocProvider<UploadPhotoBloc>(
          create: (context) =>
              UploadPhotoBloc(authRepository: AuthRepository()),
        ),
        BlocProvider<MovieBloc>(
          create: (context) => MovieBloc(movieRepository: MovieRepository()),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(AuthRepository()),
        ),
        BlocProvider<FavoriteMovieBloc>(
          create: (context) =>
              FavoriteMovieBloc(movieRepository: MovieRepository()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp(
          localizationsDelegates: [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // İngilizce
            Locale('tr'), // Türkçe
          ],
          locale: locale,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          navigatorKey: NavigationService.navigatorKey,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case AppRoutes.splash:
                return MaterialPageRoute(builder: (_) => const SplashPage());
              case AppRoutes.login:
                return MaterialPageRoute(builder: (_) => LoginPage());
              case AppRoutes.register:
                return MaterialPageRoute(builder: (_) => RegisterPage());
              case AppRoutes.uploadPhoto:
                final args = settings.arguments
                    as Map<String, dynamic>?; // arguments'ı Map olarak al
                final fromProfile = args != null && args['fromProfile'] == true;
                return MaterialPageRoute(
                  builder: (_) => UploadPhotoPage(fromProfile: fromProfile),
                );
              case AppRoutes.home:
                return MaterialPageRoute(builder: (_) => HomePage());
              case AppRoutes.profile:
                return MaterialPageRoute(builder: (_) => ProfilePage());
              case AppRoutes.main:
                return MaterialPageRoute(builder: (_) => MainScreen());
              default:
                return null;
            }
          },
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
            useMaterial3: true,
          ),
        );
      },
    );
  }
}

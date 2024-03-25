import 'package:appnew/models/popular_model.dart';
import 'package:appnew/pages/dashboard_screen.dart';
import 'package:appnew/pages/detail_movie_screen.dart';
import 'package:appnew/pages/home_page.dart';
import 'package:appnew/pages/popular_movies_screen.dart';
import 'package:flutter/material.dart';
import 'package:appnew/pages/splash_screen.dart';
import 'package:appnew/settings/app_value_notifier.dart';
import 'package:appnew/settings/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppValueNotifier.banTheme,
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: value
              ? ThemeApp.darkTheme(context)
              : ThemeApp.lightTheme(context),
          home: const SplashScreen(),
          routes: {
            "/dash": (BuildContext context) => const DashboardScreen(),
            "/recetario": (BuildContext context) =>
                HomePage(themeNotifier: AppValueNotifier.themeNotifier),
            "/movies": (BuildContext context) => const PopularMoviesScreen(),
            "/detail": (BuildContext context) {
              final popularModel =
                  ModalRoute.of(context)?.settings.arguments as PopularModel;
              return DetailMovieScreen(popularModel: popularModel);
            },
          },
        );
      },
    );
  }
}

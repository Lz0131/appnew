//import 'dart:convert';

import 'dart:convert';

import 'package:appnew/models/actor_details_model.dart';
import 'package:dio/dio.dart';
import 'package:appnew/models/popular_model.dart';

class ApiPopular {
  final String apiKey = 'db826b9d3c411ab9c29b46a6ca5b246e'; // Tu clave de API

  Future<void> addMovieToFavorites(int movieId) async {
    final String addToFavoritesURL =
        'https://api.themoviedb.org/3/account/{account_id}/favorite?api_key=$apiKey';

    try {
      // Realizar solicitud POST para agregar película a favoritos
      await dio.post(
        addToFavoritesURL,
        data: {
          'media_type': 'movie',
          'media_id': movieId,
          'favorite': true,
        },
      );
    } catch (e) {
      print('Error adding movie to favorites: $e');
      throw e;
    }
  }

  Future<void> removeMovieFromFavorites(int movieId) async {
    final String removeFromFavoritesURL =
        'https://api.themoviedb.org/3/account/{account_id}/favorite?api_key=$apiKey';

    try {
      // Realizar solicitud POST para eliminar película de favoritos
      await dio.post(
        removeFromFavoritesURL,
        data: {
          'media_type': 'movie',
          'media_id': movieId,
          'favorite': false,
        },
      );
    } catch (e) {
      print('Error removing movie from favorites: $e');
      throw e;
    }
  }

  final URL =
      "https://api.themoviedb.org/3/movie/popular?api_key=db826b9d3c411ab9c29b46a6ca5b246e&language=es-MX&page=1";
  final dio = Dio();
  Future<List<PopularModel>?> getPopularMovie() async {
    Response response = await dio.get(URL);
    if (response.statusCode == 200) {
      //print(response.data['results'].runtimeType);
      final listMoviesMap = response.data['results'] as List;
      return listMoviesMap.map((movie) => PopularModel.fromMap(movie)).toList();
    }
    return null;
  }

  Future<Map<String, dynamic>?> getMovieCredits(int movieId) async {
    final creditsURL =
        "https://api.themoviedb.org/3/movie/$movieId/credits?api_key=db826b9d3c411ab9c29b46a6ca5b246e";
    Response response = await dio.get(creditsURL);
    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }

  Future<ActorDetails?> getActorDetails(int actorId) async {
    final actorDetailsURL =
        "https://api.themoviedb.org/3/person/$actorId?api_key=db826b9d3c411ab9c29b46a6ca5b246e&language=es-MX";
    Response response = await dio.get(actorDetailsURL);
    if (response.statusCode == 200) {
      return ActorDetails.fromMap(response.data);
    }
    return null;
  }

  Future<String?> createSession(String requestToken) async {
    final String sessionUrl =
        'https://api.themoviedb.org/3/authentication/session/new?api_key=$apiKey';
    try {
      final response = await dio.post(
        sessionUrl,
        data: jsonEncode({
          'request_token': requestToken,
        }),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['session_id'];
      } else {
        print('Error al crear la sesión: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error al crear la sesión: $e');
      return null;
    }
  }
}

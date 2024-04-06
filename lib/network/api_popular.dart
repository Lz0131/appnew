//import 'dart:convert';

import 'dart:convert';

import 'package:appnew/models/actor_details_model.dart';
import 'package:dio/dio.dart';
import 'package:appnew/models/popular_model.dart';

class ApiPopular {
  //final String apiKey = '3938bb20bfc049bd98f27c2c2c365ed6'; // Tu clave de API
  //final String account_id = '21188985';
  //final String sessionId = '0106ec6532e224aaaa0e0029acd49551';

  final String apiKey = '73c295392359efe7df0a34433173fd7e'; // Tu clave de API
  final String account_id = '21061255';
  final String sessionId = '7830065d6e3615770524764247134c0ebd0e257f';
  final dio = Dio();

  Future<void> addMovieToFavorites(int movieId) async {
    final String addToFavoritesURL =
        "https://api.themoviedb.org/3/account/$account_id/favorite?api_key=$apiKey&session_id=$sessionId";
    print(addToFavoritesURL);
    final dioo = Dio();
    try {
      Map<String, dynamic> body = {
        "media_type": "movie",
        "media_id": movieId,
        "favorite": true,
      };

      Response response = await dioo.post(addToFavoritesURL, data: body);

      if (response.statusCode == 200) {
        print('Película marcada como favorita exitosamente.');
      } else {
        print(
            'Error al marcar la película como favorita. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al agregar película a favoritos: $e');
      throw e;
    }
  }

  Future<void> removeMovieFromFavorites(int movieId) async {
    final String removeFromFavoritesURL =
        'https://api.themoviedb.org/3/account/$account_id/favorite?api_key=$apiKey&session_id=$sessionId';

    try {
      final String postUrl = removeFromFavoritesURL;
      Map<String, dynamic> body = {
        "media_type": "movie",
        "media_id": movieId,
        "favorite": false
      };
      Response response = await dio.post(postUrl, data: body);
      if (response.statusCode == 200) {
        print('Película eliminada como favorita exitosamente.');
      } else {
        print(
            'Error al marcar la película como favorita. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud POST: $e');
    }
  }

  Future<List<PopularModel>?> getFavoriteMovies() async {
    final URL =
        'https://api.themoviedb.org/3/account/$account_id/favorite/movies?api_key=$apiKey&session_id=$sessionId';
    try {
      Response response = await dio.get(URL);
      if (response.statusCode == 200) {
        final List<dynamic> listMoviesMap = response.data['results'] as List;
        List<PopularModel> movies = [];
        for (var movie in listMoviesMap) {
          // Obtener el enlace del tráiler de la película
          final trailerUrl = await getMovieTrailerUrl(movie['id']);
          movies
              .add(PopularModel.fromMap({...movie, 'trailerUrl': trailerUrl}));
        }
        return movies;
      }
    } catch (e) {
      print('Error fetching popular movies: $e');
    }
    return null;
  }

  Future<List<PopularModel>?> getPopularMovie() async {
    final URL =
        "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=es-MX&page=1";
    try {
      Response response = await dio.get(URL);
      if (response.statusCode == 200) {
        final List<dynamic> listMoviesMap = response.data['results'] as List;
        List<PopularModel> movies = [];
        for (var movie in listMoviesMap) {
          // Obtener el enlace del tráiler de la película
          final trailerUrl = await getMovieTrailerUrl(movie['id']);
          movies
              .add(PopularModel.fromMap({...movie, 'trailerUrl': trailerUrl}));
        }
        return movies;
      }
    } catch (e) {
      print('Error fetching popular movies: $e');
    }
    return null;
  }

  Future<String?> getMovieTrailerUrl(int movieId) async {
    final String trailerUrl =
        "https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey&language=en-US";
    try {
      Response response = await dio.get(trailerUrl);
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'] as List;
        if (results.isNotEmpty) {
          final Map<String, dynamic> trailer = results[0];
          return 'https://www.youtube.com/watch?v=${trailer['key']}';
        }
      }
    } catch (e) {
      print('Error fetching movie trailer for movie $movieId: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>?> getMovieCredits(int movieId) async {
    final creditsURL =
        "https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey";
    Response response = await dio.get(creditsURL);
    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }

  Future<ActorDetails?> getActorDetails(int actorId) async {
    final actorDetailsURL =
        "https://api.themoviedb.org/3/person/$actorId?api_key=$apiKey&language=es-MX";
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

  Future<PopularModel?> getMovieDetails(int movieId) async {
    final String detailsUrl =
        "https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey&language=es-MX";

    try {
      Response response = await dio.get(detailsUrl);
      if (response.statusCode == 200) {
        return PopularModel.fromMap(response.data);
      }
    } catch (e) {
      print('Error al ver los detalles de la pelicula: $e');
    }
    return null;
  }
}

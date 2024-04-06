import 'dart:ui';
import 'package:appnew/models/actor_details_model.dart';
import 'package:appnew/pages/actor_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:appnew/models/popular_model.dart';
import 'package:appnew/network/api_popular.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailMovieScreen extends StatefulWidget {
  final PopularModel popularModel;

  const DetailMovieScreen({Key? key, required this.popularModel})
      : super(key: key);

  @override
  _DetailMovieScreenState createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  bool isFavorite = false;
  List<ActorDetails> actorDetailsList = [];
  bool showMovieDetails = false;
  late PopularModel movieDetails =
      PopularModel(genre: [], actors: [], trailerUrl: '');
  late bool isMovieDetailsLoading;

  @override
  void initState() {
    super.initState();
    _favoriteStatus();
    isMovieDetailsLoading = true;
    fetchMovieCredits();
    fetchMovieDetails();
  }

  void fetchMovieDetails() async {
    final movieId = widget.popularModel.id!;
    final details = await ApiPopular().getMovieDetails(movieId);
    if (details != null) {
      setState(() {
        movieDetails = details;
        isMovieDetailsLoading = false;
      });
    }
  }

  Future<void> _favoriteStatus() async {
    final String _favorite = 'favorite_${widget.popularModel.id}';
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.getBool(_favorite) ?? false;
    });
  }

  Future<void> addFavorito(int movieId) async {
    try {
      await ApiPopular().addMovieToFavorites(movieId);
    } catch (e) {
      print('Error al agregar a favoritos: $e');
    }
  }

  Future<void> removeFavorito(int movieId) async {
    try {
      await ApiPopular().removeMovieFromFavorites(movieId);
    } catch (e) {
      print('Error al agregar a favoritos: $e');
    }
  }

  void playTrailer() {
    String? trailerUrl = widget.popularModel.trailerUrl;
    if (trailerUrl != null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(trailerUrl)!,
              flags: YoutubePlayerFlags(
                autoPlay: true,
                mute: false,
              ),
            ),
            liveUIColor: Colors.amber,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        ),
      );
    } else {
      // Manejar caso donde no hay enlace de tráiler disponible
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Trailer not available'),
            content:
                Text('Sorry, the trailer for this movie is not available.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void fetchMovieCredits() async {
    print(widget.popularModel.id);
    print(
        '\n______________________________________________________________________________ \n');
    final creditsData =
        await ApiPopular().getMovieCredits(widget.popularModel.id!);
    if (creditsData != null) {
      final List<dynamic> cast = creditsData['cast'];
      List<ActorDetails> actors = [];
      for (var actor in cast) {
        final actorDetails = await ApiPopular().getActorDetails(actor['id']);
        if (actorDetails != null) {
          actors.add(actorDetails);
        }
      }
      setState(() {
        actorDetailsList = actors;
      });
    }
  }

  void showActorPopup(ActorDetails actorDetails) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ActorDetailsDialog(actorDetails: actorDetails);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String _favorite = 'favorite_${widget.popularModel.id}';
    return Scaffold(
      appBar: AppBar(
        title:
            Text(movieDetails?.title ?? ''), // Verifica si movieDetails es nulo
        actions: [
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: playTrailer,
          ),
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () async {
              setState(() {
                isFavorite = !isFavorite;
              });
              try {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool(_favorite, isFavorite);
                if (isFavorite) {
                  await addFavorito(
                      movieDetails!.id!); // Verifica si movieDetails es nulo
                } else {
                  await removeFavorito(
                      movieDetails!.id!); // Verifica si movieDetails es nulo
                }
              } catch (e) {
                setState(() {
                  isFavorite = !isFavorite;
                });
                print('Error: $e');
              }
            },
          ),
        ],
      ),
      body: isMovieDetailsLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : movieDetails != null
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      'https://image.tmdb.org/t/p/w500/${movieDetails.posterPath}',
                      fit: BoxFit.cover,
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).padding.top,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RatingBar.builder(
                              initialRating:
                                  (movieDetails.voteAverage ?? 0) / 2,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 30,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating * 2);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Descripción: ${movieDetails.overview}',
                              style: const TextStyle(
                                fontSize: 16,
                                shadows: [
                                  Shadow(
                                    blurRadius: 3,
                                    color: Colors.white,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Actores:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 3,
                                    color: Colors.white,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: actorDetailsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      showActorPopup(actorDetailsList[index]);
                                    },
                                    child: Chip(
                                      label: Text(actorDetailsList[index].name),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          if (showMovieDetails)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Géneros: ${movieDetails.genre?.join(',') ?? ''}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 3,
                                          color: Colors.white,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Titulo original: : ${movieDetails.originalTitle ?? ''}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 3,
                                          color: Colors.white,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Lenguaje original: ${movieDetails.originalLanguage ?? ''}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 3,
                                          color: Colors.white,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Fecha de lanzamiento: ${movieDetails.releaseDate ?? ''}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 3,
                                          color: Colors.white,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Popularidad: ${movieDetails.popularity ?? ''}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 3,
                                          color: Colors.white,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  showMovieDetails = !showMovieDetails;
                                });
                              },
                              child: Text(
                                showMovieDetails
                                    ? 'Ocultar detalles'
                                    : 'Más información',
                                style: const TextStyle(
                                  fontSize: 16,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 3,
                                      color: Colors.white,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text('Error al cargar los detalles de la película'),
                ),
    );
  }
}

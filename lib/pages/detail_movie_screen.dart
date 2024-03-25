import 'dart:ui';
import 'package:appnew/models/actor_details_model.dart';
import 'package:appnew/pages/actor_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:appnew/models/popular_model.dart';
import 'package:appnew/network/api_popular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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

  @override
  void initState() {
    super.initState();
    fetchMovieCredits();
  }

  void fetchMovieCredits() async {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.popularModel.title!),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
              // Aquí deberías agregar lógica para agregar o eliminar la película de la lista de favoritos
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fondo de la imagen con efecto de desenfoque
          Image.network(
            'https://image.tmdb.org/t/p/w500/${widget.popularModel.posterPath}',
            fit: BoxFit.cover,
          ),
          // Desenfoque aplicado a la imagen de fondo
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          // Contenido de la pantalla
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ), // Para ajustar el contenido debajo del AppBar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RatingBar.builder(
                    initialRating: (widget.popularModel.voteAverage ?? 0) /
                        2, // Escala de 10 a 5
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30, // Tamaño más grande de las estrellas
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating * 2); // Convertir de 5 a 10
                      // Puedes hacer algo con el rating actualizado si lo deseas
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Descripción: ${widget.popularModel.overview}',
                    style: const TextStyle(
                      fontSize: 16,
                      // Agregar efecto de sombra al texto
                      shadows: [
                        Shadow(
                          blurRadius: 3, // Radio de desenfoque
                          color: Colors.white, // Color de la sombra
                          offset: Offset(1, 1), // Desplazamiento de la sombra
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
                          blurRadius: 3, // Radio de desenfoque
                          color: Colors.white, // Color de la sombra
                          offset: Offset(1, 1), // Desplazamiento de la sombra
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50, // Altura de la lista horizontal de actores
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: actorDetailsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:appnew/models/actor_details_model.dart';
import 'package:flutter/material.dart';

class ActorDetailsDialog extends StatelessWidget {
  final ActorDetails actorDetails;

  const ActorDetailsDialog({Key? key, required this.actorDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(actorDetails.name),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (actorDetails.profilePath != null)
              Image.network(
                'https://image.tmdb.org/t/p/w500${actorDetails.profilePath}',
                width: 100,
                height: 150,
                fit: BoxFit.cover,
              ),
            Text('Biografia: ${actorDetails.biography}'),
            Text('Cumpleaños: ${actorDetails.birthday}'),
            Text('Sexo: ${actorDetails.gender == 2 ? 'Hombre' : 'Mujer'}'),
            Text('Lugar de nacimiento: ${actorDetails.placeOfBirth}'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}

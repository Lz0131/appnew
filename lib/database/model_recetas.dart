class Receta {
  final int id;
  final String name;
  final String image;
  final String description;
  final String ingredients;

  const Receta({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.ingredients,
  });

  factory Receta.fromJson(Map<String, dynamic> json) => Receta(
        id: json['id'],
        name: json['name'],
        image: json['img'],
        ingredients: json["ingredients"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': name,
        'image': image,
        'ingredients': ingredients,
        'description': description,
      };
  Receta copy() => Receta(
        id: id,
        name: name,
        image: image,
        ingredients: ingredients,
        description: description,
      );
}

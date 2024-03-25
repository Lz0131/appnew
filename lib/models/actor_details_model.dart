class ActorDetails {
  final String biography;
  final String birthday;
  final int gender;
  final String name;
  final String placeOfBirth;
  final String? profilePath;

  ActorDetails({
    required this.biography,
    required this.birthday,
    required this.gender,
    required this.name,
    required this.placeOfBirth,
    required this.profilePath,
  });

  factory ActorDetails.fromMap(Map<String, dynamic> map) {
    return ActorDetails(
      biography: map['biography'] ?? '',
      birthday: map['birthday'] ?? '',
      gender: map['gender'] ?? 0,
      name: map['name'] ?? '',
      placeOfBirth: map['place_of_birth'] ?? '',
      profilePath: map['profile_path'],
    );
  }
}

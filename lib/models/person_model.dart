import 'dart:convert';

class ResultActor {
  final int page;
  final List<Actor> actors;
  final int totalPages;
  final int totalResults;

  ResultActor({
    required this.page,
    required this.actors,
    required this.totalPages,
    required this.totalResults,
  });

  factory ResultActor.fromRawJson(String str) =>
      ResultActor.fromJson(json.decode(str));

  factory ResultActor.fromJson(Map<String, dynamic> json) => ResultActor(
        page: json["page"],
        actors: List<Actor>.from(json["results"].map((x) => Actor.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class Actor {
  final int id;
  final String name;
  final String profilePath;
  final String biography;
  final DateTime birthday;
  final String placeOfBirth;
  final List<String> alsoKnownAs;
  final String? deathday;
  final String? homepage;

  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.biography,
    required this.birthday,
    required this.placeOfBirth,
    required this.alsoKnownAs,
    this.deathday,
    this.homepage,
  });

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['profile_path']}'
          : '',
      biography: json['biography'] ?? 'No biography available.',
      birthday: json['birthday'] != null
          ? DateTime.parse(json['birthday'])
          : DateTime(1900, 1, 1),
      placeOfBirth: json['place_of_birth'] ?? 'Unknown',
      alsoKnownAs: List<String>.from(json['also_known_as'] ?? []),
      deathday: json['deathday'],
      homepage: json['homepage'],
    );
  }
}

int calcularIdade(DateTime birthday) {
  DateTime hoje = DateTime.now();
  int idade = hoje.year - birthday.year;
  if (hoje.month < birthday.month ||
      (hoje.month == birthday.month && hoje.day < birthday.day)) {
    idade--;
  }

  return idade;
}

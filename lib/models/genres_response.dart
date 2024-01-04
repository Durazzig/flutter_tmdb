// To parse this JSON data, do
//
//     final genresResponse = genresResponseFromJson(jsonString);

import 'dart:convert';

GenresResponse genresResponseFromJson(String str) =>
    GenresResponse.fromJson(json.decode(str));

String genresResponseToJson(GenresResponse data) => json.encode(data.toJson());

class GenresResponse {
  List<Genre> genres;

  GenresResponse({
    required this.genres,
  });

  factory GenresResponse.fromJson(Map<String, dynamic> json) => GenresResponse(
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
      };
}

class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

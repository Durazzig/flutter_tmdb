// To parse this JSON data, do
//
//     final watchListDetailsResponse = watchListDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:tmdb/models/movies_response.dart';

WatchListDetailsResponse watchListDetailsResponseFromJson(String str) =>
    WatchListDetailsResponse.fromJson(json.decode(str));

String watchListDetailsResponseToJson(WatchListDetailsResponse data) =>
    json.encode(data.toJson());

class WatchListDetailsResponse {
  String createdBy;
  String description;
  int favoriteCount;
  int id;
  String iso6391;
  int itemCount;
  List<Movie> movies;
  String name;
  int page;
  dynamic posterPath;
  int totalPages;
  int totalResults;

  WatchListDetailsResponse({
    required this.createdBy,
    required this.description,
    required this.favoriteCount,
    required this.id,
    required this.iso6391,
    required this.itemCount,
    required this.movies,
    required this.name,
    required this.page,
    required this.posterPath,
    required this.totalPages,
    required this.totalResults,
  });

  factory WatchListDetailsResponse.fromJson(Map<String, dynamic> json) =>
      WatchListDetailsResponse(
        createdBy: json["created_by"],
        description: json["description"],
        favoriteCount: json["favorite_count"],
        id: json["id"],
        iso6391: json["iso_639_1"],
        itemCount: json["item_count"],
        movies: List<Movie>.from(json["items"].map((x) => Movie.fromJson(x))),
        name: json["name"],
        page: json["page"],
        posterPath: json["poster_path"],
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "created_by": createdBy,
        "description": description,
        "favorite_count": favoriteCount,
        "id": id,
        "iso_639_1": iso6391,
        "item_count": itemCount,
        "items": List<dynamic>.from(movies.map((x) => x.toJson())),
        "name": name,
        "page": page,
        "poster_path": posterPath,
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

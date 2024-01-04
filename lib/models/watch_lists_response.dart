import 'dart:convert';

MovieListsResponse movieListsResponseFromJson(String str) =>
    MovieListsResponse.fromJson(json.decode(str));

String movieListsResponseToJson(MovieListsResponse data) =>
    json.encode(data.toJson());

class MovieListsResponse {
  int page;
  List<WatchList> results;
  int totalPages;
  int totalResults;

  MovieListsResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieListsResponse.fromJson(Map<String, dynamic> json) =>
      MovieListsResponse(
        page: json["page"],
        results: List<WatchList>.from(
            json["results"].map((x) => WatchList.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class WatchList {
  String description;
  int favoriteCount;
  int id;
  int itemCount;
  String iso6391;
  String listType;
  String name;
  dynamic posterPath;

  WatchList({
    required this.description,
    required this.favoriteCount,
    required this.id,
    required this.itemCount,
    required this.iso6391,
    required this.listType,
    required this.name,
    required this.posterPath,
  });

  factory WatchList.fromJson(Map<String, dynamic> json) => WatchList(
        description: json["description"],
        favoriteCount: json["favorite_count"],
        id: json["id"],
        itemCount: json["item_count"],
        iso6391: json["iso_639_1"],
        listType: json["list_type"],
        name: json["name"],
        posterPath: json["poster_path"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "favorite_count": favoriteCount,
        "id": id,
        "item_count": itemCount,
        "iso_639_1": iso6391,
        "list_type": listType,
        "name": name,
        "poster_path": posterPath,
      };
}

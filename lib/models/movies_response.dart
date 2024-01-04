// To parse this JSON data, do
//
//     final moviesResponse = moviesResponseFromJson(jsonString);

import 'dart:convert';

MoviesResponse moviesResponseFromJson(String str) =>
    MoviesResponse.fromJson(json.decode(str));

String moviesResponseToJson(MoviesResponse data) => json.encode(data.toJson());

class MoviesResponse {
  Dates? dates;
  int page;
  List<Movie?> results;
  int totalPages;
  int totalResults;

  MoviesResponse({
    this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) => MoviesResponse(
        dates: json["dates"] != null ? Dates.fromJson(json["dates"]) : null,
        page: json["page"],
        results: List<Movie?>.from(json["results"].map((x) {
          if (x["media_type"] == "movie" || x["media_type"] == "tv") {
            return Movie.fromJson(x);
          }
          return null;
        })),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "dates": dates?.toJson(),
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x?.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Dates {
  DateTime maximum;
  DateTime minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );

  Map<String, dynamic> toJson() => {
        "maximum":
            "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum":
            "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
      };
}

class Movie {
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String? originalTitle;
  String? originalName;
  String overview;
  double popularity;
  String? posterPath;
  String? mediaType;
  DateTime? releaseDate;
  DateTime? firstAirDate;
  String? title;
  String? name;
  bool? video;
  double voteAverage;
  int voteCount;

  Movie({
    required this.adult, //movie tv
    this.backdropPath, //movie tv
    required this.genreIds, //movie tv
    required this.id, //movie tv
    required this.originalLanguage, //movie tv
    this.originalTitle, //movie
    this.originalName, //m
    required this.overview, //movie tv
    required this.popularity, //movie tv
    this.posterPath, //movie tv
    this.mediaType,
    this.releaseDate, //movie
    this.firstAirDate, //tv
    this.title, //tv
    this.name, //tv
    this.video, //tv
    required this.voteAverage, //movie tv
    required this.voteCount, //movie tv
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
      id: json["id"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      originalName: json["original_name"],
      overview: json["overview"],
      popularity: json["popularity"]?.toDouble(),
      posterPath: json["poster_path"],
      mediaType: json["media_type"],
      releaseDate: (json["release_date"] != null && json["release_date"] != "")
          ? DateTime.parse(json["release_date"])
          : null,
      firstAirDate:
          (json["first_air_date"] != null && json["first_air_date"] != "")
              ? DateTime.parse(json["first_air_date"])
              : null,
      title: json["title"],
      name: json["name"],
      video: json["video"],
      voteAverage: json["vote_average"]?.toDouble(),
      voteCount: json["vote_count"],
    );
  }

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "original_name": name,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "media_type": mediaType,
        "release_date":
            "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
        "first_air_date":
            "${firstAirDate?.year.toString().padLeft(4, '0')}-${firstAirDate?.month.toString().padLeft(2, '0')}-${firstAirDate?.day.toString().padLeft(2, '0')}",
        "title": title,
        "name": name,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

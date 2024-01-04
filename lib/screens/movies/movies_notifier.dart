import 'package:flutter/material.dart';
import 'package:tmdb/api/movies_api.dart';
import 'package:tmdb/models/genres_response.dart';
import 'package:tmdb/models/movies_response.dart';

class MoviesNotifier extends ChangeNotifier {
  List<Genre> genres = [];
  late Future<List<Movie>?> nowPlayingMoviesFuture;
  MoviesApi moviesApi = MoviesApi();

  void init() async {
    nowPlayingMoviesFuture = moviesApi.getNowPlayingMovies();
  }

  Future<List<Movie>?> getTopRatedMovies() async {
    return moviesApi.getTopRatedMovies();
  }

  Future<List<Movie>?> getUpcomingMovies() async {
    return moviesApi.getUpcomingMovies();
  }

  Future<List<Movie>?> getPopularMovies() async {
    return moviesApi.getPopularMovies();
  }

  List<Genre> getGenresNames(List<int> genreIds) {
    List<Genre> genresNames = [];
    for (var id in genreIds) {
      genresNames.add(genres.firstWhere((element) => element.id == id));
    }
    return genresNames;
  }
}

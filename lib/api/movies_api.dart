import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tmdb/api/http_handler.dart';
import 'package:tmdb/api/urls.dart';
import 'package:tmdb/models/movies_response.dart';

class MoviesApi {
  Future<List<Movie>?> getNowPlayingMovies() async {
    List<Movie> movies = [];
    try {
      final response = await HttpHandler.get(
        Urls.nowPlayingMovies,
      );
      final decodedData = jsonDecode(response.body);
      movies = List<Movie>.from(
          decodedData["results"].map((x) => Movie.fromJson(x)));
      return movies;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<Movie>?> getTopRatedMovies() async {
    List<Movie> movies = [];
    try {
      final response = await HttpHandler.get(
        Urls.topRatedMovies,
      );
      final decodedData = jsonDecode(response.body);
      movies = List<Movie>.from(
          decodedData["results"].map((x) => Movie.fromJson(x)));
      return movies;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<Movie>?> getUpcomingMovies() async {
    List<Movie> movies = [];
    try {
      final response = await HttpHandler.get(
        Urls.upcomingMovies,
      );
      final decodedData = jsonDecode(response.body);
      movies = List<Movie>.from(
          decodedData["results"].map((x) => Movie.fromJson(x)));
      return movies;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<Movie>?> getPopularMovies() async {
    List<Movie> movies = [];
    try {
      final response = await HttpHandler.get(
        Urls.popularMovies,
      );
      final decodedData = jsonDecode(response.body);
      movies = List<Movie>.from(
          decodedData["results"].map((x) => Movie.fromJson(x)));
      return movies;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}

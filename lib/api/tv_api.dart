import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tmdb/api/http_handler.dart';
import 'package:tmdb/api/urls.dart';
import 'package:tmdb/models/movies_response.dart';

class TvApi {
  Future<List<Movie>?> getLatestTvShows() async {
    List<Movie> movies = [];
    try {
      final response = await HttpHandler.get(
        Urls.latestTvShows,
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

  Future<List<Movie>?> getTopRatedTvShows() async {
    List<Movie> movies = [];
    try {
      final response = await HttpHandler.get(
        Urls.topRatedTvShows,
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

  Future<List<Movie>?> getPopularTvShows() async {
    List<Movie> movies = [];
    try {
      final response = await HttpHandler.get(
        Urls.popularTvShows,
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

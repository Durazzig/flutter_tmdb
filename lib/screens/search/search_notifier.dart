import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/api/http_handler.dart';
import 'package:tmdb/api/urls.dart';
import 'package:tmdb/models/movies_response.dart';

enum LoadingState { loading, error, done, none }

class SearchNotifier extends ChangeNotifier {
  final Dio dio = Dio();
  List<Movie>? searchResults;
  String query = "";
  LoadingState loadingState = LoadingState.none;

  void searchMovie(String searchQuery) async {
    query = searchQuery;
    try {
      loadingState = LoadingState.loading;
      notifyListeners();
      final response = await HttpHandler.get(
        Urls.search(searchQuery),
      );
      final decodedData = jsonDecode(response.body);
      searchResults =
          MoviesResponse.fromJson(decodedData).results.whereNotNull().toList();
      loadingState = LoadingState.done;
      notifyListeners();
    } catch (e) {
      loadingState = LoadingState.error;
      notifyListeners();
    }
  }
}

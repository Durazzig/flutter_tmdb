import 'package:flutter/material.dart';
import 'package:tmdb/api/tv_api.dart';
import 'package:tmdb/models/movies_response.dart';

class TvNotifier extends ChangeNotifier {
  late PageController pageController;
  late Future<List<Movie>?> latestTvShowsFuture;
  TvApi tvApi = TvApi();

  void init() async {
    pageController = PageController();
    latestTvShowsFuture = getLatestTvShows();
  }

  Future<List<Movie>?> getLatestTvShows() async {
    return tvApi.getLatestTvShows();
  }

  Future<List<Movie>?> getTopRatedTvShows() async {
    return tvApi.getTopRatedTvShows();
  }

  Future<List<Movie>?> getPopularTvShows() async {
    return tvApi.getPopularTvShows();
  }
}

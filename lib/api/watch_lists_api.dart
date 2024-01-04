import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tmdb/api/http_handler.dart';
import 'package:tmdb/api/urls.dart';
import 'package:tmdb/local/my_preferences.dart';
import 'package:tmdb/models/watch_list_details_response.dart';
import 'package:tmdb/models/watch_lists_response.dart';

class WatchListsApi {
  Future<List<WatchList>?> getWatchLists() async {
    List<WatchList> movies = [];
    try {
      final sessionId = await MyAppPreferences.getSessionId();
      final profile = await MyAppPreferences.getProfile();
      final response = await HttpHandler.get(
        Urls.getWatchListsUrl(sessionId, profile.id),
      );
      final decodedData = jsonDecode(response.body);
      movies = List<WatchList>.from(
          decodedData["results"].map((x) => WatchList.fromJson(x)));
      return movies;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<WatchListDetailsResponse?> getWatchListDetails(
      {required int listId}) async {
    WatchListDetailsResponse watchListDetails;
    try {
      final response = await HttpHandler.get(
        Urls.getWatchListsDetailsUrl(listId),
      );
      final decodedData = jsonDecode(response.body);
      watchListDetails = WatchListDetailsResponse.fromJson(decodedData);
      return watchListDetails;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}

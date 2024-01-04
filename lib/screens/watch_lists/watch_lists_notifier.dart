import 'package:flutter/material.dart';
import 'package:tmdb/api/watch_lists_api.dart';
import 'package:tmdb/models/watch_list_details_response.dart';
import 'package:tmdb/models/watch_lists_response.dart';

class WatchListsNotifier extends ChangeNotifier {
  final bool hasSessionId;
  late Future<List<WatchList>?> watchListsFuture;
  WatchListsApi watchListsApi = WatchListsApi();
  int selectedListId = 0;

  WatchListsNotifier({
    required this.hasSessionId,
  });

  void init() async {
    watchListsFuture = getWatchLists();
  }

  void setSelectedListId(WatchList list) {
    selectedListId = list.id;
  }

  Future<List<WatchList>?> getWatchLists() async {
    return watchListsApi.getWatchLists();
  }

  Future<WatchListDetailsResponse?> getWatchListDetails() async {
    return watchListsApi.getWatchListDetails(listId: selectedListId);
  }
}

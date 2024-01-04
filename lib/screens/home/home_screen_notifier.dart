import 'package:flutter/material.dart';

class HomeScreenNotifier extends ChangeNotifier {
  int index = 0;
  late PageController pageController;

  final bool hasSessionId;

  HomeScreenNotifier({
    required this.hasSessionId,
  });

  void init() {
    pageController = PageController();
  }

  // void getLists() async {
  //   final sessionId = await MyAppPreferences.getSessionId();
  // }

  void changePage(int value) {
    index = value;
    pageController.jumpToPage(value);
    notifyListeners();
  }
}

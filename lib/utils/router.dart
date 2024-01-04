import 'package:flutter/material.dart';

class AppRouter {
  late NavigatorState navigator;

  AppRouter(BuildContext context) {
    navigator = Navigator.of(context);
  }

  static AppRouter of(BuildContext context) => AppRouter(context);

  Future<void> goToScreen(Widget screen) async {
    await navigator.push(_createRoute(screen));
  }

  Future<void> goToScreenAndReplace(Widget screen) async {
    navigator.popUntil((route) => route.isFirst);
    await navigator.pushReplacement(_createRoute(screen));
  }

  Future<void> goToScreenAndClear(Widget screen) async {
    await navigator.pushAndRemoveUntil(
      _createRoute(screen),
      (route) => false,
    );
  }

  void pop() => navigator.pop();

  void popUntil(int count) {
    var temp = 0;
    navigator.popUntil((route) {
      return temp++ == count;
    });
  }

  PageRouteBuilder _createRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => screen,
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInBack;
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

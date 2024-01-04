import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HttpHandler {
  static Future<http.Response> post(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    final errorResponse = http.Response('No internet connection', 1000);
    if (await InternetConnectionChecker.createInstance().hasConnection) {
      if (kDebugMode) {
        log("REQUEST URL:::::::: $url");
        log("REQUEST BODY:::::::: ${jsonEncode(body)}");
      }
      final response = await http
          .post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      )
          .timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          return http.Response(
              "{\"message\":\"Something went wrong, please try again later\"}",
              408);
        },
      ).catchError((onError) {
        return http.Response(
            "{\"message\":\"Something went wrong, please try again later\"}",
            500);
      });
      if (kDebugMode) {
        log("REQUEST RESPONSE:::::::: ${response.body}");
      }
      return response;
    }
    return errorResponse;
  }

  static Future<http.Response> get(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    final errorResponse = http.Response('No internet connection', 1000);

    if (await InternetConnectionChecker.createInstance().hasConnection) {
      if (kDebugMode) {
        log("REQUEST URL:::::::: $url");
        log("REQUEST BODY:::::::: ${jsonEncode(body)}");
      }
      final response = await http
          .get(
        Uri.parse(url),
      )
          .timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          return http.Response(
              "{\"message\":\"Something went wrong, please try again later\"}",
              408);
        },
      ).catchError((onError) => http.Response(
              "{\"message\":\"Something went wrong, please try again later\"}",
              500));
      if (kDebugMode) {
        log("REQUEST RESPONSE:::::::: ${response.body}");
      }
      return response;
    }
    return errorResponse;
  }
}

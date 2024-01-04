import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tmdb/api/http_handler.dart';
import 'package:tmdb/api/urls.dart';
import 'package:tmdb/local/my_preferences.dart';
import 'package:tmdb/models/profile_response.dart';

class AuthApi {
  Future<String> getRequestToken() async {
    String requestToken = "";
    final response = await HttpHandler.get(
      Urls.getRequestToken,
    );
    final decodedData = jsonDecode(response.body);
    requestToken = decodedData["request_token"];
    debugPrint(requestToken);
    return requestToken;
  }

  Future<ProfileResponse?> getProfileInformation(String sessionId) async {
    ProfileResponse? profile;
    try {
      final response = await HttpHandler.get(
        Urls.getProfileInformationUrl(sessionId),
      );
      final decodedData = jsonDecode(response.body);
      profile = ProfileResponse.fromJson(decodedData);
      MyAppPreferences.setProfile(profile);
      return profile;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<String?> getSessionID(String requestToken) async {
    String sessionId = "";
    try {
      final response = await HttpHandler.post(
        Urls.getSessionId,
        body: {
          "request_token": requestToken,
        },
      );
      final decodedData = jsonDecode(response.body);
      sessionId = decodedData["session_id"];
      MyAppPreferences.setSessionId(sessionId);
      debugPrint(sessionId);
      return sessionId;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<String?> getSessionIdFromPreferences() async {
    try {
      final session = await MyAppPreferences.getSessionId();
      if (session == "") {
        return null;
      } else {
        final profileResponse = await getProfileInformation(session);
        if (profileResponse == null) {
          return "";
        }
        return session;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}

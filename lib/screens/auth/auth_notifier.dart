import 'package:flutter/material.dart';
import 'package:tmdb/api/auth_api.dart';
import 'package:tmdb/models/profile_response.dart';

class AuthNotifier extends ChangeNotifier {
  String requestToken = "";
  String sessionId = "";
  final AuthApi authApi = AuthApi();

  Future<void> getRequestToken() async {
    requestToken = await authApi.getRequestToken();
  }

  Future<String?> getSessionID() async {
    try {
      final response = await authApi.getSessionID(requestToken);
      sessionId = response!;
      return sessionId;
    } catch (e) {
      return null;
    }
  }

  Future<String?> getSessionIdFromPreferences() async {
    return authApi.getSessionIdFromPreferences();
  }

  Future<ProfileResponse?> getProfileInformation() async {
    return await authApi.getProfileInformation(sessionId);
  }
}

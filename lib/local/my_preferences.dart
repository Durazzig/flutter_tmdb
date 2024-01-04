import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb/models/profile_response.dart';

class MyAppPreferences {
  static final MyAppPreferences _instance = MyAppPreferences._internal();

  factory MyAppPreferences() {
    return _instance;
  }

  MyAppPreferences._internal() {
    SharedPreferences.getInstance().then((value) {
      return preferences = value;
    });
  }

  late SharedPreferences preferences;

  static Future<void> clearPreferences() async {
    await _instance.preferences.clear();
  }

  static Future<void> setSessionId(String sessionId) async {
    await _instance.preferences.setString("session_id", sessionId);
  }

  static Future<String> getSessionId() async {
    return _instance.preferences.getString("session_id") ?? "";
  }

  static Future<void> setProfile(ProfileResponse profile) async {
    final userJson = jsonEncode(profile.toJson());
    await _instance.preferences.setString("profile", userJson);
  }

  static Future<ProfileResponse> getProfile() async {
    final userJson = _instance.preferences.getString("profile") ?? "";
    return ProfileResponse.fromJson(jsonDecode(userJson));
  }
}

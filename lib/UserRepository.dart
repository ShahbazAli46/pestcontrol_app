import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'jsonModels/LoginResponse.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginResponseStorage {
  static const String _responseKey = 'login_response';
  static const String _tokenKey = 'auth_token';

  static Future<void> saveLoginResponse(LoginResponse loginResponse) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(loginResponse.toJson());
    await prefs.setString(_responseKey, jsonString);

    // Save token separately
    if (loginResponse.token != null) {
      await prefs.setString(_tokenKey, loginResponse.token!);
    }
  }

  static Future<LoginResponse?> getLoginResponse() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_responseKey);
    if (jsonString == null) {
      return null;
    }
    final jsonMap = json.decode(jsonString);
    return LoginResponse.fromJson(jsonMap);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> clearLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_responseKey);
    await prefs.remove(_tokenKey);
  }
}
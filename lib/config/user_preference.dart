import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class UserPreference {
  final SharedPreferences prefs;
  UserPreference(this.prefs);

  setToken(String newToken) async {
    debugPrint("SAVED TOKEN => $newToken");
    await prefs.setString("token", newToken);
  }

  String? getToken() {
    return prefs.getString("token");
  }

  setOnChat(bool onChat) async {
    await prefs.setBool("chat", onChat);
  }

  bool getOnChat() {
    return prefs.getBool("chat") ?? false;
  }

  setUser(UserModel data) async {
    await prefs.setString("user", json.encode(data.toJson()));
  }

  UserModel getUser() {
    if (prefs.getString("user") != null) {
      try {
        return UserModel.fromJson(json.decode(prefs.getString("user") ?? ""));
      } catch (e) {
        return UserModel();
      }
    } else {
      return UserModel();
    }
  }

  clearData() {
    prefs.clear();
  }
}

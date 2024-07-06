import 'dart:convert';

import 'package:auctions/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalService {
  final _userKey = "userKey";

  Future<bool> login(User user) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(_userKey)) {
      return false;
    }

    final userStrData = jsonEncode(user.toPrefs());
    return prefs.setString(_userKey, userStrData);
  }

  Future<User?> getLoggedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userStrData = prefs.getString(_userKey);
    if (userStrData == null) {
      return null;
    }

    return User.fromPrefs(jsonDecode(userStrData));
  }

  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}

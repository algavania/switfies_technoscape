import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/auth/auth_model.dart';
import '../../data/models/user/user_model.dart';

class SharedPreferencesService {
  static Future<SharedPreferences> get _instance async =>
      prefs ??= await SharedPreferences.getInstance();
  static SharedPreferences? prefs;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    prefs = await _instance;
    return prefs ?? await SharedPreferences.getInstance();
  }

  static Future<void> clearAllPrefs() async {
    await prefs?.clear();
  }

  static Future<void> setUserData(UserModel? model) async {
    await prefs?.setString('user', jsonEncode(model?.toJson()));
  }

  static UserModel? getUserData() {
    String? json = prefs?.getString('user');
    if (json != null) {
      UserModel model = UserModel.fromJson(jsonDecode(json));
      return model;
    }
    return null;
  }

  static Future<void> setAuthData(AuthModel? model) async {
    await prefs?.setString('auth', jsonEncode(model?.toJson()));
  }

  static AuthModel? getAuthData() {
    String? json = prefs?.getString('auth');
    if (json != null) {
      AuthModel model = AuthModel.fromJson(jsonDecode(json));
      return model;
    }
    return null;
  }
}

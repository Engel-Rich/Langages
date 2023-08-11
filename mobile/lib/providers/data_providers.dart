import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/models/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../commons/fonctions.dart';

class UserProvider extends GetxController {
  String? tokenuser;
  UserApp? currenUser;
  ThemeMode currentTheme = ThemeMode.system;
  static UserProvider get user => Get.find();

  void setToken(String token) {
    tokenuser = token;
    update();
  }

  void setCurrentUser(UserApp user) {
    currenUser = user;
    update();
  }

  Future<void> saveToken(token) async {
    final preference = await SharedPreferences.getInstance();
    await preference.setString(tokenLocal, token);
    // end
  }

  Future<void> saveCurrentUser(UserApp userApp) async {
    final preference = await SharedPreferences.getInstance();
    await preference.setString(userLocal, jsonEncode(userApp.toMap()));
  }

  Future<void> getDatas() async {
    final preference = await SharedPreferences.getInstance();
    final token = preference.getString(tokenLocal);
    final userapp = preference.getString(userLocal);
    final String mode = preference.getString(themeLocal) ?? theme[0]!;
    setThemode(thememode[mode]!);
    if (userapp != null) setCurrentUser(UserApp.fromMap(jsonDecode(userapp)));
    printer(token ?? "Pas d'utilisateur connecté");
    if (token != null) setToken(token);
    printer(mode);
    // End
  }

  Future logOut() async {
    final preference = await SharedPreferences.getInstance();
    await preference.remove(tokenLocal);
    await preference.remove(userLocal);
  }

  setThemode(ThemeMode mode) {
    currentTheme = mode;
    update();
  }

  Future saveTheme(String theme) async {
    final preference = await SharedPreferences.getInstance();
    await preference.setString(themeLocal, theme);
  }

  // End
}

const String tokenLocal = 'local_token';
const String userLocal = 'user_token';
const String themeLocal = 'theme_local';
const Map<int, String> theme = {0: "system", 1: "light", -1: 'dark'};
Map<String, ThemeMode> thememode = {
  theme[0]!: ThemeMode.system,
  theme[1]!: ThemeMode.light,
  theme[-1]!: ThemeMode.dark,
};

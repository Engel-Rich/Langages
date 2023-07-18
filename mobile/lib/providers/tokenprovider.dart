import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobile/models/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../commons/fonctions.dart';

class UserProvider extends GetxController {
  String? tokenuser;
  UserApp? currenUser;

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

  Future<void> getToken() async {
    final preference = await SharedPreferences.getInstance();
    final token = preference.getString(tokenLocal);
    final userapp = preference.getString(userLocal);
    if (userapp != null) setCurrentUser(UserApp.fromMap(jsonDecode(userapp)));
    printer(token ?? "Pas d'utilisateur connecté");
    if (token != null) setToken(token);
    // End
  }

  // End
}

const String tokenLocal = 'local_token';
const String userLocal = 'user_token';

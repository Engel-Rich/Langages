// ignore_for_file: non_constant_identifier_names, body_might_complete_normally_catch_error

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobile/commons/constances.dart';
import 'package:mobile/commons/fonctions.dart';
import 'package:mobile/models/users.dart';
import 'package:mobile/providers/tokenprovider.dart';

class UserController {
  // Register user
  Future<Map<String, dynamic>> registerUser(UserApp userApp) async {
    final dio = Dio();
    try {
      return await dio
          .post('$base_url/api/user/register', data: userApp.toMap())
          .then(
        (value) async {
          final data = value.data;
          if (value.statusCode == 200) {
            final token = data['result']['token'];
            final user_provider = UserProvider.user;
            user_provider.setToken(token);
            await user_provider.saveToken(token);
            return {'statu': true, 'code': value.statusCode};
          } else {
            return {
              'statu': false,
              'code': value.statusCode,
              'message': data['message']
            };
          }
        },
      ).catchError((error) {
        toasterError(error);
        return {'statu': false, 'message': error.toString()};
      });
    } on DioException catch (error) {
      return {
        'statu': false,
        'message': error.message ??
            'Erreur de connection au serveur ${error.response?.statusCode}'
      };
    } on HttpException catch (error) {
      return {
        'statu': false,
        'message': error.message,
      };
    } on SocketException catch (error) {
      return {
        'statu': false,
        'message': error.message,
      };
    }
  }

  // Login user

  Future<Map<String, dynamic>> loginUser(
      String user_email, String user_password) async {
    final dio = Dio();
    final data = {
      'email': user_email,
      'password': user_password,
    };
    try {
      return await dio.post('$base_url/api/user/login', data: data).then(
        (value) async {
          // printer(value.statusCode);
          if (value.statusCode == 200) {
            final datat = value.data;
            final token = datat['result']['token'];
            final user_provider = UserProvider.user;
            user_provider.setToken(token);
            await user_provider.saveToken(token);
            return {'statu': true, 'code': value.statusCode};
          } else {
            return {
              'statu': false,
              'code': value.statusCode,
              'message': value.data['message']
            };
          }
        },
      ).catchError((error) {
        toasterError(error);
        return {'statu': false, 'message': error.toString()};
      });
    } on DioException catch (error) {
      return {
        'statu': false,
        'message': error.message ??
            'Erreur de connection au serveur ${error.response?.statusCode}'
      };
    } on HttpException catch (error) {
      return {
        'statu': false,
        'message': error.message,
      };
    } on SocketException catch (error) {
      return {
        'statu': false,
        'message': error.message,
      };
    }
  }

  // Get User

  Future<UserApp?> getUser() async {
    final dio = Dio();
    final user_provider = UserProvider.user;
    await user_provider.getToken();
    printer(authorization());
    return await dio
        .get(
      '$base_url/api/user/show',
      options: Options(
        headers: authorization(),
      ),
    )
        .then(
      (value) {
        if (value.statusCode == 200) {
          final data = value.data;
          // printer(data);
          final user = UserApp.fromMap(data['result']);
          printer(user.toMap());
          return user;
        } else {
          return null;
        }
      },
    ).catchError((error) {
      toasterError(error);
      return null;
    });
  }

  // end
}

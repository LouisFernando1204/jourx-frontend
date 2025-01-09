import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jourx/view_model/login_viewmodel.dart';
import 'package:jourx/model/model.dart';

class Repository {
  final apiUrl = "https://jourx.dickyyyy.site";

  Future<Map<String, dynamic>> registerAccount(String name, String email,
      String password, String ttl, String gender) async {
    try {
      final response =
          await http.post(Uri.parse("$apiUrl/api/register"), body: {
        'name': name,
        'email': email,
        'password': password,
        'birth_date': ttl,
        'gender': gender
      });

      var jsonResponse = jsonDecode(response.body);
      var responseMessage = jsonResponse['message'];

      if (response.statusCode == 201) {
        var userData = jsonResponse['data']['user'];
        User user = User.fromJson(userData);
        var tokenResponse = jsonResponse['token'];

        return {
          'status': Status.success,
          'user': user,
          'token': tokenResponse,
          'message': 'Register berhasil!'
        };
      } else {
        print("masuk sini errornya 2");

        return {
          'status': Status.error,
          'user': null,
          'token': null,
          'message': responseMessage
        };
      }
    } catch (error) {
      print("masuk sini errornya");

      return {
        'status': Status.error,
        'user': null,
        'token': null,
        'message': error.toString()
      };
    }
  }

  Future<Map<String, dynamic>> loginAccount(
      String email, String password) async {
    try {
      final response = await http.post(Uri.parse("$apiUrl/api/login"),
          body: {'email': email, 'password': password});
      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var userData = jsonResponse['data']['user'];
        User user = User.fromJson(userData);
        var tokenResponse = jsonResponse['token'];

        return {
          'status': Status.success,
          'user': user,
          'token': tokenResponse,
          'message': 'Login berhasil!'
        };
      } else {
        var responseMessage = jsonResponse['message'];

        return {
          'status': Status.error,
          'user': null,
          'token': null,
          'message': responseMessage
        };
      }
    } catch (_) {
      return {
        'status': Status.error,
        'user': null,
        'token': null,
        'message': 'Validation failed!'
      };
    }
  }

  Future<Map<String, dynamic>> registerAccountFromGmail(
      String name, String ttl, String gender, String email, String uid) async {
    try {
      final response = await http
          .post(Uri.parse("$apiUrl/api/register_with_google"), body: {
        'name': name,
        'email': email,
        'uid': uid,
        'birth_date': ttl,
        'gender': gender
      });

      var jsonResponse = jsonDecode(response.body);
      var responseMessage = jsonResponse['message'];

      if (response.statusCode == 201) {
        var userData = jsonResponse['data']['user'];
        User returnUser = User.fromJson(userData);
        User user = User(
            userId: returnUser.userId,
            uid: returnUser.uid,
            name: returnUser.name,
            email: email,
            birthDate: returnUser.birthDate,
            gender: returnUser.gender);
        var tokenResponse = jsonResponse['token'];

        return {
          'status': Status.success,
          'user': user,
          'token': tokenResponse,
          'message': 'Register berhasil!'
        };
      } else {
        return {
          'status': Status.error,
          'user': null,
          'token': null,
          'message': responseMessage
        };
      }
    } catch (_) {
      return {
        'status': Status.error,
        'user': null,
        'token': null,
        'message': 'Validation failed!'
      };
    }
  }

  Future<Map<String, dynamic>> loginAccountFromGmail(
      String uid, String email) async {
    try {
      final response =
          await http.post(Uri.parse("$apiUrl/api/login_with_google"), body: {
        'uid': uid,
      });

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var userData = jsonResponse['data']['user'];
        User returnUser = User.fromJson(userData);

        User user = User(
            userId: returnUser.userId,
            uid: returnUser.uid,
            name: returnUser.name,
            email: email,
            birthDate: returnUser.birthDate,
            gender: returnUser.gender);

        var tokenResponse = jsonResponse['token'];

        print(user);

        return {
          'status': Status.success,
          'user': user,
          'token': tokenResponse,
          'message': 'Register berhasil!'
        };
      } else {
        print("masuk sini errornya 2");

        return {
          'status': Status.error,
          'user': null,
          'token': null,
          'message': 'Valudation failed!'
        };
      }
    } catch (_) {
      return {
        'status': Status.error,
        'user': null,
        'token': null,
        'message': 'Validation failed!'
      };
    }
  }
}

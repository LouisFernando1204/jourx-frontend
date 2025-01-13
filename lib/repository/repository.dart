import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jourx/data/network/network_api_services.dart';
import 'package:jourx/model/model.dart';
import 'package:jourx/data/response/status.dart';

class Repository {
  final apiUrl = "https://jourx.dickyyyy.site";
  final _apiServices = NetworkApiServices();
  

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
        var tokenResponse = jsonResponse['data']['token'];

        return {
          'status': Status.completed,
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
        var tokenResponse = jsonResponse['data']['token'];

        return {
          'status': Status.completed,
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
        var tokenResponse = jsonResponse['data']['token'];

        return {
          'status': Status.completed,
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

        var tokenResponse = jsonResponse['data']['token'];

        print(user);

        return {
          'status': Status.completed,
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

  Future<Map<String, dynamic>> logoutAccount(String token) async {
    try {
      if (token.isEmpty) {
        return {
          'status': Status.error,
          'message': 'No token found. User might already be logged out.'
        };
      }
      final Map<String, dynamic> body = {
      'content': "halo",
    };

      dynamic response = await _apiServices.postApiResponse('/api/logout', body,bearerToken: token);

      if (response.statusCode == 200) {
        return {
          'status': Status.completed,
          'message': 'Logout berhasil!'
        };
      } else {
        var jsonResponse = jsonDecode(response.body);
        var responseMessage = jsonResponse['message'] ?? 'Logout failed!';

        return {
          'status': Status.error,
          'message': responseMessage
        };
      }
    } catch (error) {
      return {
        'status': Status.error,
        'message': error.toString()
      };
    }
  }
}

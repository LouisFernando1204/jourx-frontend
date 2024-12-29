import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jourx/view_model/login_viewmodel.dart';
import 'package:jourx/model/model.dart';

class Repository {
  final apiUrl = "https://jourx.dickyyyy.site";

  Future<Map<String, dynamic>> registerAccount(String name, String username,
      String email, String password, String ttl, String gender) async {
    try {
      final response =
          await http.post(Uri.parse("${apiUrl}/api/register"), body: {
        'name': name,
        'username': username,
        'email': email,
        'password': password,
        'birth_date': ttl,
        'gender': gender
      });
      var jsonResponse = jsonDecode(response.body);
      var message = jsonResponse['message'];
      if (response.statusCode == 201) {
        return {'status': Status.success, 'message': message};
      } else {
        return {'status': Status.error, 'message': message};
      }
    } catch (error) {
      return {'status': Status.error, 'message': error};
    }
  }

  Future<Map<String, dynamic>> loginAccount(
      String email, String password) async {
    try {
      final response = await http.post(Uri.parse("${apiUrl}/api/login"),
          body: {'email': email, 'password': password});
      var jsonResponse = jsonDecode(response.body);
      var message = jsonResponse['message'];
      if (response.statusCode == 200) {
        var userData = jsonResponse['data']['user'];
        User user = User.fromJson(userData);
        return {'status': Status.success, 'user': user, 'message': message};
      } else {
        return {'status': Status.error, 'user': null, 'message': message};
      }
    } catch (error) {
      return {'status': Status.error, 'user': null, 'message': error};
    }
  }

  Future<Map<String, dynamic>> checkAccount(String email) async {
    try {
      final response = await http.post(Uri.parse("${apiUrl}/api/check_status"),
          body: {'email': email});
      var jsonResponse = jsonDecode(response.body);
      var message = jsonResponse['message'];
      if (response.statusCode == 200) {
        var userData = jsonResponse['data']['user'];
        User user = User.fromJson(userData);
        return {'status': Status.success, 'user': user, 'message': message};
      } else {
        return {'status': Status.error, 'user': null, 'message': message};
      }
    } catch (error) {
      return {'status': Status.error, 'user': null, 'message': error};
    }
  }
}

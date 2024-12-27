import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jourx/view_model/login_viewmodel.dart';
import 'package:jourx/model/model.dart';

class Repository {
  final apiUrl = "https://jourx.dickyyyy.site";

  Future<Status> registerAccount(String name, String username, String email,
      String password, String ttl, String gender) async {
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
      if (response.statusCode == 201) {
        return Status.success;
      } else {
        var errorResponse = jsonDecode(response.body);
        throw errorResponse['message'];
      }
    } catch (error) {
      return Status.error;
    }
  }

  Future<Map<String, dynamic>> loginAccount(
      String email, String password) async {
    try {
      final response = await http.post(Uri.parse("${apiUrl}/api/login"),
          body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var userData = jsonResponse['data']['user'];
        User user = User.fromJson(userData);

        return {
          'status': Status.success,
          'user': user,
        };
      } else {
        var errorResponse = jsonDecode(response.body);
        throw errorResponse['message'];
      }
    } catch (error) {

      return {
        'status': Status.error,
        'user': null,
      };
    }
  }
}

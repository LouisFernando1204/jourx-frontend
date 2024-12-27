import 'package:flutter/material.dart';
import 'package:jourx/repository/repository.dart';
import 'package:jourx/model/model.dart';

enum Status { error, success, none }

class LoginViewmodel with ChangeNotifier {
  final _repo = Repository();

  Status loginStatus = Status.none;
  User? user;
  Future<dynamic> loginWithoutGmail(String email, String password) async {
    try {
      loginStatus = Status.none;
      notifyListeners();
      var result = await _repo.loginAccount(email, password);
      loginStatus = result['status'];
      if (loginStatus == Status.success) {
        user = result['user'];
        print("Login successful: ${user!.name}");
      } 
    } catch (error) {
      loginStatus = Status.error;
      print("Error during registration: $error");
      notifyListeners();
    }
  }

  Status registerStatus = Status.none;
  Future<dynamic> registerAccount(String name, String username, String email,
      String password, String ttl, String gender) async {
    try {
      registerStatus = Status.none;
      notifyListeners();
      registerStatus = await _repo.registerAccount(
          name, username, email, password, ttl, gender);
      notifyListeners();
    } catch (error) {
      registerStatus = Status.error;
      print("Error during registration: $error");
      notifyListeners();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:jourx/repository/repository.dart';

enum Status { error, success, none }

class LoginViewmodel with ChangeNotifier {
  final _repo = Repository();

  Future<dynamic> loginWithoutGmail(String email, String password) async {
    _repo.loginAccount(email, password);
  }

  Status registerStatus = Status.none;
  Future<void> registerAccount(String name, String username, String email,
      String password, String ttl, String gender) async {
    try {
      registerStatus = Status.none;
      notifyListeners();
      registerStatus = await _repo.registerAccount(name, username, email, password, ttl, gender);
      notifyListeners();
    } catch (error) {
      registerStatus = Status.error;
      print("Error during registration: $error");
      notifyListeners();
    }
  }
}

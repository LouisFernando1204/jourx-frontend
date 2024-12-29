import 'package:flutter/material.dart';
import 'package:jourx/repository/repository.dart';
import 'package:jourx/model/model.dart';

enum Status { error, success, none }

class LoginViewmodel with ChangeNotifier {
  final _repo = Repository();

  Status loginStatus = Status.none;
  User? user;
  String? loginErrorMessage;

  Future<void> loginWithoutGmail(String email, String password) async {
    
    loginStatus = Status.none;
    loginErrorMessage = "";
    notifyListeners();

    try {

      var result = await _repo.loginAccount(email, password);
      loginStatus = result['status'];

      if (loginStatus == Status.success) {

        user = result['user'];
        notifyListeners();

      } 
      else if (loginStatus == Status.error) {

        loginErrorMessage = result['message'];
        notifyListeners();
      
      }
    } 
    catch (error) {

      loginStatus = Status.error;
      loginErrorMessage = error.toString();
      notifyListeners();

    }
  }

  Status registerStatus = Status.none;
  String? registerErrorMessage;

  Future<void> registerAccount(String name, String username, String email,
      String password, String ttl, String gender) async {

    registerStatus = Status.none;
    registerErrorMessage = "";
    notifyListeners();

    try {

      var result = await _repo.registerAccount(
          name, username, email, password, ttl, gender);
      registerStatus = result['status'];

      if (registerStatus == Status.error) {
        registerErrorMessage = result['message'];
      }

      notifyListeners();

    } 
    catch (error) {

      registerStatus = Status.error;
      registerErrorMessage = error.toString();
      notifyListeners();

    }
  }

  Status checkAccountStatus = Status.none;
  String? checkAccountErrorMessage;
  User? loginUser;

  Future<void> checkAccount(String email) async {

    checkAccountStatus = Status.none;
    checkAccountErrorMessage = "";
    notifyListeners();

    try {

      var result = await _repo.checkAccount(email);
      checkAccountStatus = result['status'];

      if (checkAccountStatus == Status.error) {
        checkAccountErrorMessage = result['message'];
      }

      loginUser = result['user'];
      notifyListeners();

    } 
    catch (error) {

      checkAccountStatus = Status.error;
      checkAccountErrorMessage = error.toString();
      notifyListeners();

    }
  }
}

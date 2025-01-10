import 'package:flutter/material.dart';
import 'package:jourx/repository/repository.dart';
import 'package:jourx/model/model.dart';
import 'package:jourx/data/response/status.dart';

// enum LoginRegisterStatus { error, completed, notStarted }

class LoginViewmodel with ChangeNotifier {
  final _repo = Repository();
  User? user;
  String? token;

  Status loginStatus = Status.notStarted;
  String? loginErrorMessage;

  Future<void> loginWithoutGmail(String email, String password) async {
    loginStatus = Status.notStarted;
    loginErrorMessage = "";
    user = null;
    token = "";
    notifyListeners();

    try {
      var result = await _repo.loginAccount(email, password);
      loginStatus = result['status'];

      if (loginStatus == Status.completed) {
        user = result['user'];
        token = result['token'];
      } else if (loginStatus == Status.error) {
        loginErrorMessage = result['message'];
      }

      notifyListeners();
    } catch (error) {
      loginStatus = Status.error;
      loginErrorMessage = error.toString();
      notifyListeners();
    }
  }

  Status registerStatus = Status.notStarted;
  String? registerErrorMessage;

  Future<void> registerAccount(String name, String email, String password,
      String ttl, String gender) async {
    registerStatus = Status.notStarted;
    registerErrorMessage = "";
    user = null;
    token = "";

    notifyListeners();

    try {
      var result =
          await _repo.registerAccount(name, email, password, ttl, gender);
      registerStatus = result['status'];

      if (registerStatus == Status.error) {
        registerErrorMessage = result['message'];
      } else {
        user = result['user'];
        token = result['token'];
      }

      notifyListeners();
    } catch (error) {
      registerStatus = Status.error;
      registerErrorMessage = error.toString();
      notifyListeners();
    }
  }

  Status registerFromGmailStatus = Status.notStarted;
  String? registerFromGmailErrorMessage;

  Future<void> registerAccountFromGmail(
      String name, String ttl, String gender, String email, String uid) async {
    registerFromGmailStatus = Status.notStarted;
    registerFromGmailErrorMessage = "";
    user = null;
    token = "";

    notifyListeners();

    try {
      var result =
          await _repo.registerAccountFromGmail(name, ttl, gender, email, uid);
      registerFromGmailStatus = result['status'];

      if (registerFromGmailStatus == Status.error) {
        registerFromGmailErrorMessage = result['message'];
      } else {
        user = result['user'];
        token = result['token'];
      }

      notifyListeners();
    } catch (error) {
      registerFromGmailStatus = Status.error;
      registerFromGmailErrorMessage = error.toString();
      notifyListeners();
    }
  }

  Status loginFromGmailStatus = Status.notStarted;
  String? loginFromGmailErrorMessage;

  Future<void> loginAccountFromGmail(String uid, String email) async {
    loginFromGmailStatus = Status.notStarted;
    loginFromGmailErrorMessage = "";
    user = null;
    token = "";

    notifyListeners();

    try {
      var result = await _repo.loginAccountFromGmail(uid, email);
      loginFromGmailStatus = result['status'];

      if (loginFromGmailStatus == Status.error) {
        loginFromGmailErrorMessage = result['message'];
      } else {
        user = result['user'];
        token = result['token'];
      }

      notifyListeners();
    } catch (error) {
      loginFromGmailStatus = Status.error;
      loginFromGmailErrorMessage = error.toString();
      notifyListeners();
    }
  }
}

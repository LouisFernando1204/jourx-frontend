import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jourx/repository/repository.dart';

class LoginViewmodel with ChangeNotifier {
  final _repo = Repository();

  Future<dynamic> loginWithoutGmail(String email, String password) async {}

  Future<dynamic> loginWithGmail() async {
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> registerAccount(String username, String email,
      String password, String ttl, String gender) async {}
}

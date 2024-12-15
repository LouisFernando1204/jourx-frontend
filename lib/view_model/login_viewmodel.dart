import 'package:flutter/material.dart';
import 'package:jourx/repository/repository.dart';

class LoginViewmodel with ChangeNotifier {
  final _repo = Repository();

  Future<dynamic> registerAccount(String username, String email,
      String password, String ttl, String gender) async {}

  Future<dynamic> loginWithoutGmail(String email, String password) async {}

  Future<dynamic> loginWithGmail() async {}
}

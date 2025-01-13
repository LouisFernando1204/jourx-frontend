import 'package:jourx/data/response/status.dart';
import 'package:jourx/repository/repository.dart';

class LogoutViewModel {
  final Repository _repo = Repository(); 

  Future<Map<String, dynamic>> logout(String token) async {
    if (token.isEmpty) {
      return {
        'status': Status.error,
        'message': 'Token is empty. Please login first.'
      };
    }

    final result = await _repo.logoutAccount(token);
    return result;
  }
}
part of 'model.dart';

class User extends Equatable {
  final String? userId;
  final String? name;
  final String? username;
  final String? password;
  final DateTime? birthDate;
  final Enum? gender;

  const User(
      {this.userId,
      this.name,
      this.username,
      this.password,
      this.birthDate,
      this.gender});

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json['user_id'] as String?,
        name: json['name'] as String?,
        username: json['username'] as String?,
        password: json['password'] as String?,
        birthDate: json['birth_date'] as DateTime?,
        gender: json['gender'] as Enum?,
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'name': name,
        'username': username,
        'password': password,
        'birth_date': birthDate,
        'gender': gender
      };

  @override
  List<Object?> get props {
    return [userId, name, username, password, birthDate, gender];
  }
}

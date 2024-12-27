part of 'model.dart';

enum Gender { male, female, other }  // Define the gender Enum

class User extends Equatable {
  final int? userId;
  final String? name;
  final String? username;
  final DateTime? birthDate;
  final Gender? gender;

  const User({
    this.userId,
    this.name,
    this.username,
    this.birthDate,
    this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'] as int?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      birthDate: DateTime.parse(json['birth_date']),
      gender: _genderFromString(json['gender']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': userId,
        'name': name,
        'username': username,
        'birth_date': birthDate?.toIso8601String(),
        'gender': gender?.toString(),
      };

  static Gender? _genderFromString(String? genderStr) {
    if (genderStr == null) return null;
    switch (genderStr.toLowerCase()) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      case 'other':
        return Gender.other;
      default:
        return null;
    }
  }

  @override
  List<Object?> get props {
    return [userId, name, username, birthDate, gender];
  }
}
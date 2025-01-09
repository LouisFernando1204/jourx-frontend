part of 'model.dart';

enum Gender { male, female, other } // Define the gender Enum

class User extends Equatable {
  final int? userId;
  final String? uid;
  final String? name;
  final String? email;
  final DateTime? birthDate;
  final Gender? gender;

  const User({
    this.userId,
    this.uid,
    this.name,
    this.email,
    this.birthDate,
    this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'] as int?,
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      birthDate: DateTime.parse(json['birth_date']),
      gender: _genderFromString(json['gender']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': userId,
        'uid': uid,
        'name': name,
        'email': email,
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
    return [userId, uid, name, email, birthDate, gender];
  }
}

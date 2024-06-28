import 'dart:convert';

class UserModel {
  final int? id;
  final String? username;
  final String? password;
  UserModel({
    this.id,
    this.username,
    this.password,
  });

  Map<String, dynamic> toLogin() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt(),
      username: map['username'],
      password: map['password'],
    );
  }
}

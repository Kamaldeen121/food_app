import 'package:flutter/foundation.dart';

class SigninPayload {
  final String phone;
  final String password;
  final String name;
  final String email;
  SigninPayload(this.name, this.email,
      {required this.phone, required this.password});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['f-name'] = this.name;
    data['email'] = this.email;

    return data;
  }

  factory SigninPayload.fromJson(Map<String, dynamic> json) {
    return SigninPayload(
      json['f-name'],
      json['email'],
      phone: json['phone'],
      password: json['password'],
    );
  }
}

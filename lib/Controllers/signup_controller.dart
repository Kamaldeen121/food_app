import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_app/contants/services/signup_services.dart';
import 'package:food_app/models/signup_payload.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends ChangeNotifier {
  final SignupServices signupServices;
  SignupController({required this.signupServices}) {
    loadUserData();
  }
  late List<SignupPayload> userList = [];
  bool isloading = false;
  String responseMessage = '';
  SignupPayload? addUser;
  bool isRegister = false;

  Future<void> registerUser(SignupPayload user) async {
    isloading = true;
    notifyListeners();

    final response = await signupServices.registerUser(user);
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      isRegister = true;
      responseMessage = 'Register Successful';
      await pref.setBool('isRegister', true);
      await pref.setString('f_name', user.name);
      await pref.setString('phone', user.phone);
      await pref.setString('email', user.email);
      await pref.setString('password', user.password);

      final newUser = SignupPayload(
        name: user.name,
        phone: user.phone,
        email: user.email,
        password: user.password,
      );
      print('User added: ${response.data}');
      print('New user : ${newUser.toJson()}');

      userList.add(newUser);
      addUser = newUser;
      responseMessage = 'User added successfully';
    } else {
      responseMessage = 'User not added';
    }

    isloading = false;
    notifyListeners();
  }

  Future<void> loadUserData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    isRegister = pref.getBool('isRegister') ?? false;
    String? phone = pref.getString('phone');
    String? name = pref.getString('f_name');
    String? email = pref.getString('email');
    String? password = pref.getString('password');

    if (isRegister &&
        phone != null &&
        name != null &&
        email != null &&
        password != null) {
      addUser = SignupPayload(
        name: name,
        phone: phone,
        email: email,
        password: password,
      );
    }
    notifyListeners();
  }

  Future<void> fetchUserProfile() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await signupServices.fetchUserProfile();

    if (response.statusCode == 200) {
      final userData = response.data['user'];

      await pref.setString('f_name', userData['f_name'] ?? '');
      await pref.setString('email', userData['email'] ?? '');
      await pref.setString('phone', userData['phone'] ?? '');

      loadUserData(); // Update UI after fetching user data
    }
  }
}

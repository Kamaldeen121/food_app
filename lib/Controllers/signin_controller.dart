import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_app/contants/services/signin_services.dart';
import 'package:food_app/models/signin_payload.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  final SigninServices signinServices;
  LoginController({required this.signinServices}) {
    loadUserData();
  }

  late List<SigninPayload> userList = [];
  bool isLoading = false;
  String responseMessage = '';
  SigninPayload? loginUsers;
  bool isLoggedIn = false;
  bool isLoggedOut = false;

  Future<void> loginUser(SigninPayload loginUser) async {
    isLoading = true;

    final response = await signinServices.loginUser(loginUser);
    final SharedPreferences pref = await SharedPreferences.getInstance();

    if (response.statusCode == 200) {
      isLoggedIn = true;
      responseMessage = response.statusMessage ?? 'Login Successful';

      await pref.setBool('isLoggedIn', true);
      await pref.setString('phone', loginUser.phone);
      await pref.setString('password', loginUser.password);
      await pref.setString('f_name', loginUser.name);
      await pref.setString('email', loginUser.email);

      final user = SigninPayload(loginUser.name, loginUser.email,
          phone: loginUser.phone, password: loginUser.password);
      userList.add(user);
      loginUsers = user;
    } else {
      responseMessage = response.statusMessage ?? 'Login Failed';
      isLoggedIn = false;
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadUserData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    isLoggedIn = pref.getBool('isLoggedIn') ?? false;
    String? phone = pref.getString('phone');
    String? password = pref.getString('password');
    String? name = pref.getString('f_name');
    String? email = pref.getString('email');

    if (isLoggedIn && phone != null && password != null) {
      loginUsers = SigninPayload(name ?? '', email ?? '',
          phone: phone, password: password);
      print('${loginUsers}');
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> logoutUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    print('user logged out');
    notifyListeners();

    // Clears all stored data

    isLoggedIn = false;
    notifyListeners();
    loginUsers = null;
    responseMessage = 'Logged Out';
    isLoggedOut = true;
    notifyListeners();

    isLoading = false;
    notifyListeners();
  }
}

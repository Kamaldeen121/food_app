import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Controllers/popular_controller.dart';
import 'package:food_app/contants/services/signin_services.dart';
import 'package:food_app/models/signin_payload.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  final SigninServices signinServices;
  final PopularController popularController;

  LoginController(
      {required this.signinServices, required this.popularController}) {
    loadUserData();
  }

  late List<SigninPayload> userList = [];
  bool isLoading = false;
  String responseMessage = '';
  SigninPayload? loginUsers;
  bool isLoggedIn = false;

  Future<void> loginUser(SigninPayload loginUser) async {
    isLoading = true;
    notifyListeners();

    final response = await signinServices.loginUser(loginUser);
    final SharedPreferences pref = await SharedPreferences.getInstance();

    if (response.statusCode == 200) {
      isLoggedIn = true;
      responseMessage = 'Login Successful';

      final responseData = response.data;
      final token = responseData['token'];

      await pref.setBool('isLoggedIn', true);
      await pref.setString('token', token);
      await pref.setString('phone', loginUser.phone);
      await pref.setString('password', loginUser.password);

      await fetchUserProfile();

      loginUsers = SigninPayload(
        pref.getString('f_name') ?? '',
        pref.getString('email') ?? '',
        phone: loginUser.phone,
        password: loginUser.password,
      );

      await popularController.loadCartItems();
      await popularController.loadCartHistoryItems();
    } else {
      responseMessage = 'Login Failed';
      isLoggedIn = false;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchUserProfile() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await signinServices.fetchUserProfile();

    if (response.statusCode == 200) {
      final userData = response.data['user'];

      await pref.setString('f_name', userData['f_name']);
      await pref.setString('email', userData['email']);
      await pref.setString('phone', userData['phone']);

      loadUserData();
    }
  }

  Future<void> loadUserData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    isLoggedIn = pref.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      loginUsers = SigninPayload(
        pref.getString('f_name') ?? 'No name',
        pref.getString('email') ?? 'No email',
        phone: pref.getString('phone') ?? 'No phone',
        password: pref.getString('password') ?? '',
      );
    }
    await popularController.loadCartItems();
    await popularController.loadCartHistoryItems();
    notifyListeners();
  }

  Future<void> logoutUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();

    isLoggedIn = false;
    loginUsers = null;
    responseMessage = 'Logged Out';
    isLoading = false;

    popularController.cartItems.clear();
    popularController.cartHistoryItems.clear();
    await popularController.dbHelper.clearCart();
    notifyListeners();
  }
}

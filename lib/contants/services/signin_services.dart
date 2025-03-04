import 'package:dio/dio.dart';
import 'package:food_app/contants/api_client.dart';
import 'package:food_app/models/signin_payload.dart';
import 'package:food_app/models/signup_payload.dart';

class SigninServices {
  final ApiClient apiClient;

  SigninServices({required this.apiClient});

  Future<Response> loginUser(SigninPayload loginUser) async {
    final payload = loginUser.toJson();
    return await apiClient.postData('/api/v1/auth/login', payload);
  }
}

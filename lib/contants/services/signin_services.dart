import 'package:dio/dio.dart';
import 'package:food_app/contants/api_client.dart';
import 'package:food_app/models/signin_payload.dart';

class SigninServices {
  final ApiClient apiClient;

  SigninServices({required this.apiClient});

  Future<Response> loginUser(SigninPayload loginUser) async {
    final payload = loginUser.toJson();
    return await apiClient.postData(
      '/api/v1/auth/login',
      payload,
    );
  }

  Future<Response> fetchUserProfile() async {
    return await apiClient.getData(
        '/api/v1/user/profile'); // ✅ Token is already handled in ApiClient
  }
}

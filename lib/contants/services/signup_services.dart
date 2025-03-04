import 'package:dio/dio.dart';
import 'package:food_app/contants/api_client.dart';
import 'package:food_app/models/signup_payload.dart';

class SignupServices {
  final ApiClient apiClient;

  SignupServices({required this.apiClient});

  Future<Response> registerUser(SignupPayload newUser) async {
    final payload = newUser.toJson();
    return await apiClient.postData('/api/v1/auth/register', payload);
  }
}

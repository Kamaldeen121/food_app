import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://mvs.bslmeiyu.com',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  ApiClient() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _getToken(); // ✅ Get token from SharedPreferences
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        options.headers['Accept'] = 'application/json';
        return handler.next(options);
      },
    ));
  }

  Future<String?> _getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token'); // ✅ Retrieve saved token
  }

  Future<Response> getData(String endpoint) async {
    try {
      Response response = await dio.get(endpoint);
      return response;
    } on DioException {
      return Response(
        statusCode: 1,
        statusMessage: 'Something went wrong',
        requestOptions: RequestOptions(path: endpoint),
      );
    } on SocketException {
      rethrow;
    } catch (e) {
      return Response(
        statusCode: 1,
        statusMessage: e.toString(),
        requestOptions: RequestOptions(path: endpoint),
      );
    }
  }

  Future<Response> postData(
      String endpoint, Map<String, dynamic> payload) async {
    try {
      Response response = await dio.post(endpoint, data: payload);
      return response;
    } on DioException catch (e) {
      print('DioException: ${e.response}');
      print('${e.response}');
      String errorMessage = 'Something went wrong';
      if (e.response != null && e.response!.data['errors'] is List) {
        errorMessage = (e.response!.data['errors'] as List).join(', ');
      } else if (e.response != null && e.response!.data['errors'] is String) {
        errorMessage = e.response!.data['errors'];
      }
      return Response(
        requestOptions: RequestOptions(path: endpoint),
        statusMessage: errorMessage,
      );
    } on SocketException {
      rethrow;
    }
  }
}

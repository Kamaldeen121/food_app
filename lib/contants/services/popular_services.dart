import 'package:dio/dio.dart';
import 'package:food_app/contants/api_client.dart';

class PopularServices {
  ApiClient? apiClient;
  PopularServices({this.apiClient});
  Future<Response> getPopularProducts() async {
    Response response = await apiClient!.getData('/api/v1/products/popular');
    return response;
  }
}

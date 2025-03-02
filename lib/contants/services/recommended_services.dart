import 'package:dio/dio.dart';
import 'package:food_app/contants/api_client.dart';

class RecommendedServices {
  ApiClient? apiClient;
  RecommendedServices({this.apiClient});
  Future<Response> getRecommendedProducts() async {
    Response response =
        await apiClient!.getData('/api/v1/products/recommended');
    return response;
  }
}

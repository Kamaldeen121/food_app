import 'package:flutter/material.dart';
import 'package:food_app/contants/services/popular_services.dart';
import 'package:food_app/contants/services/recommended_services.dart';
import 'package:food_app/models/product_model.dart';

class CartItem {
  final Products product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

class RecommendedController extends ChangeNotifier {
  RecommendedServices? recommendedServices;
  RecommendedController({this.recommendedServices});
  List<Products>? productList = [];
  List<CartItem> cartItems = [];

  bool isLoading = false;

  Future<void> getRecommendedProducts() async {
    if (isLoading || recommendedServices == null)
      return; // Prevent multiple calls

    isLoading = true;
    notifyListeners();

    final response = await recommendedServices!.getRecommendedProducts();

    if (response.statusCode == 200) {
      final decodedData = response.data;

      final product = ProductModel.fromJson(decodedData);
      productList!.addAll(product.productList!);

      isLoading = false;
      notifyListeners();
    } else {
      print('Failed to load products');
      isLoading = false;
      notifyListeners();
    }
  }

  void addToCart(Products product, int quantity) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      cartItems[index].quantity += quantity;
    } else {
      cartItems.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void removeFromCart(Products product) {
    cartItems.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  int get cartCount => cartItems.length;

  List<CartItem> get cartItem => cartItems;
}

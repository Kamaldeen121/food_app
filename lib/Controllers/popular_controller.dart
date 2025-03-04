import 'package:flutter/material.dart';
import 'package:food_app/contants/services/popular_services.dart';
import 'package:food_app/models/product_model.dart';

class CartItem {
  final Products product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

class CartHistoryItem {
  final Products product;
  final int quantity;
  final DateTime dateTime;

  CartHistoryItem({
    required this.product,
    required this.quantity,
    required this.dateTime,
  });
}

class PopularController extends ChangeNotifier {
  PopularServices? popularServices;
  PopularController({this.popularServices});
  List<Products>? productList = [];
  List<CartItem> cartItems = [];
  List<CartHistoryItem> cartHistoryItems = [];
  bool isloading = false;

  Future<void> getPopularProducts() async {
    if (isloading || popularServices == null) return; // Prevent multiple calls

    isloading = true;
    notifyListeners();

    final response = await popularServices!.getPopularProducts();

    if (response.statusCode == 200) {
      final decodedData = response.data;

      final product = ProductModel.fromJson(decodedData);
      productList!.addAll(product.productList!);

      isloading = false;
      notifyListeners();
    } else {
      print('Failed to load products');
      isloading = false;
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

  void moveToCartHistory() {
    final now = DateTime.now();
    cartItems.forEach((cartItem) {
      cartHistoryItems.add(CartHistoryItem(
        product: cartItem.product,
        quantity: cartItem.quantity,
        dateTime: now,
      ));
    });
    cartItems.clear();
    notifyListeners();
  }

  int get cartCount => cartItems.length;

  List<CartItem> get cartItem => cartItems;

  List<CartHistoryItem> get cartHistory => cartHistoryItems;
}

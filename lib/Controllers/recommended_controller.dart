import 'package:flutter/material.dart';
import 'package:food_app/contants/dbHelper/db_helper.dart';
import 'package:food_app/contants/services/recommended_services.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/Controllers/popular_controller.dart'
    show CartItem, CartHistoryItem;

class RecommendedController extends ChangeNotifier {
  RecommendedServices? recommendedServices;
  RecommendedController({this.recommendedServices});
  List<Products>? productList = [];
  List<CartItem> cartItems = [];
  List<CartHistoryItem> cartHistoryItems = [];
  bool isloading = false;

  final DbHelper dbHelper = DbHelper();

  Future<void> getRecommendedProducts() async {
    if (isloading || recommendedServices == null)
      return; // Prevent multiple calls

    isloading = true;
    notifyListeners();

    final response = await recommendedServices!.getRecommendedProducts();

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

  Future<void> addToCart(Products product, int quantity) async {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      cartItems[index].quantity += quantity;
    } else {
      final cartItem = CartItem(product: product, quantity: quantity);
      cartItems.add(cartItem);
      await dbHelper.insertCartItem(cartItem);
    }
    notifyListeners();
  }

  Future<void> removeFromCart(Products product) async {
    cartItems.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  Future<void> moveToCartHistory() async {
    final now = DateTime.now();
    for (var cartItem in cartItems) {
      final cartHistoryItem = CartHistoryItem(
        product: cartItem.product,
        quantity: cartItem.quantity,
        dateTime: now,
      );
      cartHistoryItems.add(cartHistoryItem);
      await dbHelper.insertCartHistoryItem(cartHistoryItem);
    }
    cartItems.clear();
    await dbHelper.clearCart();
    notifyListeners();
  }

  Future<void> loadCartItems() async {
    cartItems = (await dbHelper.getCartItems()).cast<CartItem>();
    notifyListeners();
  }

  Future<void> loadCartHistoryItems() async {
    cartHistoryItems =
        (await dbHelper.getCartHistoryItems()).cast<CartHistoryItem>();
    notifyListeners();
  }

  int get cartCount => cartItems.length;

  List<CartItem> get cartItem => cartItems;

  List<CartHistoryItem> get cartHistory => cartHistoryItems;
}

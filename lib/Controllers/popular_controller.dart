import 'package:flutter/material.dart';
import 'package:food_app/contants/dbHelper/db_helper.dart';
import 'package:food_app/contants/services/popular_services.dart';
import 'package:food_app/models/product_model.dart';

class CartItem {
  final Products product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'productId': product.id,
      'name': product.name,
      'price': product.price,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: Products(
        id: map['productId'],
        name: map['name'],
        price: map['price'],
      ),
      quantity: map['quantity'],
    );
  }
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

  Map<String, dynamic> toMap() {
    return {
      'productId': product.id,
      'name': product.name,
      'price': product.price,
      'quantity': quantity,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory CartHistoryItem.fromMap(Map<String, dynamic> map) {
    return CartHistoryItem(
      product: Products(
        id: map['productId'],
        name: map['name'],
        price: map['price'],
      ),
      quantity: map['quantity'],
      dateTime: DateTime.parse(map['dateTime']),
    );
  }
}

class PopularController extends ChangeNotifier {
  PopularServices? popularServices;
  PopularController({this.popularServices});
  List<Products>? productList = [];
  List<CartItem> cartItems = [];
  List<CartHistoryItem> cartHistoryItems = [];
  bool isloading = false;

  final DbHelper dbHelper = DbHelper();

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
    cartItems = await dbHelper.getCartItems();
    notifyListeners();
  }

  Future<void> loadCartHistoryItems() async {
    cartHistoryItems = await dbHelper.getCartHistoryItems();
    notifyListeners();
  }

  int get cartCount => cartItems.length;

  List<CartItem> get cartItem => cartItems;

  List<CartHistoryItem> get cartHistory => cartHistoryItems;
}

import 'dart:async';
import 'package:food_app/Controllers/popular_controller.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:food_app/models/product_model.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  factory DbHelper() => _instance;
  static Database? _database;

  DbHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'food_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart (
        id INTEGER PRIMARY KEY,
        productId TEXT,
        name TEXT,
        price REAL,
        quantity INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE cart_history (
        id INTEGER PRIMARY KEY,
        productId TEXT,
        name TEXT,
        price REAL,
        quantity INTEGER,
        dateTime TEXT
      )
    ''');
  }

  Future<void> insertCartItem(CartItem cartItem) async {
    final db = await database;
    await db.insert('cart', cartItem.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertCartHistoryItem(CartHistoryItem cartHistoryItem) async {
    final db = await database;
    await db.insert('cart_history', cartHistoryItem.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CartItem>> getCartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart');
    return List.generate(maps.length, (i) {
      return CartItem.fromMap(maps[i]);
    });
  }

  Future<List<CartHistoryItem>> getCartHistoryItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart_history');
    return List.generate(maps.length, (i) {
      return CartHistoryItem.fromMap(maps[i]);
    });
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart');
  }
}

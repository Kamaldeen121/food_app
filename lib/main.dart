import 'package:flutter/material.dart';
import 'package:food_app/Controllers/popular_controller.dart';
import 'package:food_app/Controllers/recommended_controller.dart';
import 'package:food_app/contants/api_client.dart';
import 'package:food_app/contants/services/popular_services.dart';
import 'package:food_app/contants/services/recommended_services.dart';
import 'package:food_app/pages/bottom_navbar_page.dart';
import 'package:food_app/pages/cart_history_page.dart';
import 'package:food_app/pages/main_food_page.dart';
import 'package:food_app/pages/profile_page.dart';
import 'package:food_app/pages/signin_page.dart';
import 'package:food_app/pages/signup_page.dart';
import 'package:food_app/pages/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => PopularController(
              popularServices: PopularServices(apiClient: ApiClient()))),
      ChangeNotifierProvider(
          create: (_) => RecommendedController(
              recommendedServices: RecommendedServices(apiClient: ApiClient())))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen());
  }
}

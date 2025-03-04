import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/Controllers/popular_controller.dart';
import 'package:food_app/Controllers/recommended_controller.dart';
import 'package:food_app/Controllers/signin_controller.dart';
import 'package:food_app/Controllers/signup_controller.dart';
import 'package:food_app/contants/api_client.dart';
import 'package:food_app/contants/services/popular_services.dart';
import 'package:food_app/contants/services/recommended_services.dart';
import 'package:food_app/contants/services/signin_services.dart';
import 'package:food_app/contants/services/signup_services.dart';
import 'package:food_app/pages/bottom_navbar_page.dart';
import 'package:food_app/pages/cart_history_page.dart';
import 'package:food_app/pages/main_food_page.dart';
import 'package:food_app/pages/profile_page.dart';
import 'package:food_app/pages/signin_page.dart';
import 'package:food_app/pages/signup_page.dart';
import 'package:food_app/pages/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => PopularController(
              popularServices: PopularServices(apiClient: ApiClient()))),
      ChangeNotifierProvider(
          create: (_) => RecommendedController(
              recommendedServices:
                  RecommendedServices(apiClient: ApiClient()))),
      ChangeNotifierProvider(
          create: (_) => SignupController(
              signupServices: SignupServices(apiClient: ApiClient()))),
      ChangeNotifierProvider(
          create: (_) => LoginController(
              signinServices: SigninServices(apiClient: ApiClient()))),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360.0, 772.0),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: SplashScreen()),
    );
  }
}

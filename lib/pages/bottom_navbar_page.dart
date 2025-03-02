import 'package:flutter/material.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/pages/cart_history_page.dart';
import 'package:food_app/pages/cart_page.dart';
import 'package:food_app/pages/main_food_page.dart';
import 'package:food_app/pages/profile_page.dart';
import 'package:food_app/pages/signin_page.dart';
import 'package:food_app/pages/signup_page.dart';

class BottomNavbarPage extends StatefulWidget {
  const BottomNavbarPage({super.key});

  @override
  State<BottomNavbarPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BottomNavbarPage> {
  List<Widget> pages = [
    MainFoodPage(),
    SigninPage(),
    CartHistoryPage(),
    ProfilePage()
  ];

  int activeIndex = 0;

  late VoidCallbackAction callbackAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[activeIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.mainColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: AppColors.yellowColor,
          currentIndex: activeIndex,
          onTap: (index) {
            activeIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                label: 'home',
                icon: Icon(
                  Icons.home,
                )),
            BottomNavigationBarItem(
                label: 'Archive',
                icon: Icon(
                  Icons.archive_sharp,
                )),
            BottomNavigationBarItem(
                label: 'Cart',
                icon: Icon(
                  Icons.shopping_cart,
                )),
            BottomNavigationBarItem(
                label: 'profil',
                icon: Icon(
                  Icons.person,
                )),
          ]),
    );
  }
}

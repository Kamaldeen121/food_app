import 'package:flutter/material.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/pages/main_food_page.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/container_and_icon.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: ContainerAndIcon(
                    icon: Icons.arrow_back_ios_new,
                    color: AppColors.mainColor,
                    iconColor: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainFoodPage()));
                      },
                      child: ContainerAndIcon(
                        icon: Icons.home,
                        color: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    ContainerAndIcon(
                      icon: Icons.shopping_cart_sharp,
                      color: AppColors.mainColor,
                      iconColor: Colors.white,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

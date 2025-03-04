import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/container_and_icon.dart';

class EmtyCartpage extends StatefulWidget {
  const EmtyCartpage({super.key});

  @override
  State<EmtyCartpage> createState() => _EmtyCartpageState();
}

class _EmtyCartpageState extends State<EmtyCartpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8).r,
            child: ContainerAndIcon(
              icon: Icons.shopping_cart,
              iconColor: Colors.white,
              color: Colors.amber,
            ),
          )
        ],
        title: BigText(
          text: 'Cart History',
          color: Colors.white,
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/empty carton.jpg'),
          SizedBox(
            height: 10,
          ),
          BigText(
            text: 'YOU HAVENT PURCHSASED ANYTHING YET',
            color: AppColors.mainblackColor,
          )
        ],
      )),
    );
  }
}

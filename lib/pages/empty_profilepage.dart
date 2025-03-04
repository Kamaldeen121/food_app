import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/pages/signin_page.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/navigate_button.dart';

class EmptyProfilepage extends StatefulWidget {
  const EmptyProfilepage({super.key});

  @override
  State<EmptyProfilepage> createState() => _EmptyProfilepageState();
}

class _EmptyProfilepageState extends State<EmptyProfilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          centerTitle: true,
          title: BigText(
            text: 'Profile',
            color: Colors.white,
          ),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/bicycle.png'),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SigninPage()));
                },
                child: NavigateButton(
                  navigateText: 'SiGN IN',
                  height: 100,
                  width: double.maxFinite.w,
                ),
              ),
            )
          ],
        )));
  }
}

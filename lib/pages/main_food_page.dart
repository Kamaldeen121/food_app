import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/pages/main_food_view.dart';
import 'package:food_app/pages/popular_food_view.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  final PageController pageController = PageController(viewportFraction: 0.76);
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPage = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(
                        text: 'Bangledqash',
                        color: AppColors.mainColor,
                      ),
                      Row(
                        children: [
                          SmallText(
                            text: 'Nagreeb',
                            fontSize: 13,
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      )
                    ],
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(
                      Icons.search,
                      color: AppColors.iconColor1,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MainFoodView(pageController: pageController),
            SizedBox(
              height: 10,
            ),
            DotsIndicator(
              dotsCount: 5,
              position: _currentPage,
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  BigText(text: 'Popular'),
                  SizedBox(
                    width: 10,
                  ),
                  SmallText(text: '.'),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SmallText(
                      text: 'Food following',
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            PopularFoodView(),
          ],
        ),
      ),
    );
  }
}

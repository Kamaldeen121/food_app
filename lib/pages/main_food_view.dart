import 'package:flutter/material.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/pages/mainfood_detail_page.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/icon_and_text.dart';
import 'package:food_app/widgets/small_text.dart';

class MainFoodView extends StatelessWidget {
  const MainFoodView({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.maxFinite,
      child: PageView.builder(
        reverse: false,
        itemCount: 5,
        controller: pageController,
        padEnds: false,
        itemBuilder: (context, index) {
          double scale = 2.0;
          if (pageController.position.haveDimensions) {
            scale = (1 - (pageController.page! - index).abs() * 0.3)
                .clamp(0.8, 2.0);
          }
          return Transform(
            transformHitTests: true,
            transform: Matrix4.diagonal3Values(1, 1, 1),
            child: Stack(children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainfoodDetailPage()));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 0),
                  height: 220,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'images/yellow-food.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(
                      left: 27,
                    ),
                    height: 110,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(text: 'Chinese Slide'),
                        Row(
                          children: [
                            ...List.generate(5, (index) {
                              return Icon(
                                Icons.star,
                                color: AppColors.mainColor,
                                size: 15,
                              );
                            }),
                            SizedBox(
                              width: 10,
                            ),
                            SmallText(
                              text: '4.5',
                              fontSize: 8,
                              fontWeight: FontWeight.w200,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SmallText(
                              text: '1927',
                              fontSize: 8,
                              fontWeight: FontWeight.w200,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SmallText(
                              text: 'chinese slide',
                              fontSize: 8,
                              fontWeight: FontWeight.w200,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconandText(
                              icon: Icons.help_rounded,
                              text: 'moreeee',
                              iconColor: AppColors.yellowColor,
                            ),
                            IconandText(
                              icon: Icons.location_on,
                              text: 'Place',
                              iconColor: AppColors.mainColor,
                            ),
                            IconandText(
                              icon: Icons.access_time_sharp,
                              text: 'Time',
                              iconColor: AppColors.iconColor1,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/pages/popular_detailpage.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/icon_and_text.dart';
import 'package:food_app/widgets/small_text.dart';

class PopularFoodView extends StatelessWidget {
  const PopularFoodView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PopularDetailpage()));
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 120,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'images/SUYA.jpg',
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BigText(text: 'Nutritious Fruit meal......'),
                        ),
                        SmallText(text: 'nutricioys meal for the body'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              IconandText(
                                icon: Icons.help_rounded,
                                text: 'moreeee',
                                iconColor: AppColors.yellowColor,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              IconandText(
                                icon: Icons.location_on,
                                text: 'Place',
                                iconColor: AppColors.mainColor,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              IconandText(
                                icon: Icons.access_time_sharp,
                                text: 'Time',
                                iconColor: AppColors.iconColor1,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

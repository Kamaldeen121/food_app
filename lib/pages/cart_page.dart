import 'package:flutter/material.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/pages/main_food_page.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/container_and_icon.dart';
import 'package:food_app/widgets/icon_and_text.dart';
import 'package:food_app/widgets/small_text.dart';

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
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (contxet, index) {
                  return Container(
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
                            'images/GREENFOOD.jpg',
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
                              child:
                                  BigText(text: 'Nutritious Fruit meal......'),
                            ),
                            SmallText(
                              text: 'Food',
                              color: Colors.black54,
                            ),
                            Row(
                              children: [
                                BigText(
                                  text: '\$ 33.0',
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.remove),
                                      BigText(text: '0'),
                                      Icon(Icons.add)
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

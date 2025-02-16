import 'package:flutter/material.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/pages/cart_page.dart';
import 'package:food_app/pages/main_food_page.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/container_and_icon.dart';
import 'package:food_app/widgets/icon_and_text.dart';
import 'package:food_app/widgets/small_text.dart';

class MainfoodDetailPage extends StatefulWidget {
  const MainfoodDetailPage({super.key});

  @override
  _MainfoodDetailPageState createState() => _MainfoodDetailPageState();
}

class _MainfoodDetailPageState extends State<MainfoodDetailPage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'images/yellow-food.jpg',
                width: double.maxFinite,
                height: MediaQuery.sizeOf(context).height / 2,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainFoodPage()));
                      },
                      child: ContainerAndIcon(
                        icon: Icons.arrow_back_ios_outlined,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartPage()));
                        },
                        child: ContainerAndIcon(icon: Icons.shopping_cart)),
                  ],
                ),
              ),
              Positioned(
                bottom: -40, // Adjust the bottom position as needed
                left: MediaQuery.of(context).size.width / 2 -
                    240, // Center the container
                child: Container(
                  height: 150,
                  width: 480,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(text: 'Biriani'),
                        SizedBox(
                          height: 10,
                        ),
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
                              text: 'Biriani',
                              fontSize: 8,
                              fontWeight: FontWeight.w200,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
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
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: 'Introduce'),
                    SizedBox(
                      height: 20,
                    ),
                    SmallText(
                      text:
                          'Biryani (/bɜːrˈjɑːni/) is a mixed rice dish popular in South Asia, made with rice, meat (chicken, goat, lamb, beef) or seafood (prawns or fish), and spices. To cater to vegetarians, the meat or seafood can be substituted with vegetables or paneer.[1] Sometimes eggs or potatoes are also added.[2] Biryani is one of the most popular dishes among the South Asian diaspora, although the dish is often associated with the regions Muslim population in particular.[3] Similar dishes are also prepared in Iran, Iraq, Myanmar, Thailand, and Malaysia.[4] Biryani is the single most-ordered dish on Indian online food ordering and delivery services, and has been labelled as the most popular dish overall in India.[5][6]',
                      textOverflow: TextOverflow.visible,
                      maxLines: isExpanded ? null : 4,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Row(
                        children: [
                          SmallText(
                            text: isExpanded ? 'See Less' : 'See More',
                            color: AppColors.mainColor,
                          ),
                          Icon(isExpanded
                              ? Icons.arrow_drop_up_sharp
                              : Icons.arrow_drop_down_sharp)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        height: 120,
        width: 200,
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.remove),
                  BigText(text: '0'),
                  Icon(Icons.add)
                ],
              ),
            ),
            Container(
              height: 60,
              width: 170,
              decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BigText(
                    text: '\$12.0',
                    color: Colors.white,
                  ),
                  SmallText(
                    text: 'Add to cart',
                    color: Colors.white,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/pages/cart_page.dart';
import 'package:food_app/pages/main_food_page.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/container_and_icon.dart';
import 'package:food_app/widgets/icon_and_text.dart';
import 'package:food_app/widgets/small_text.dart';

class PopularDetailpage extends StatefulWidget {
  const PopularDetailpage({super.key});

  @override
  MainfoodDetailPageState createState() => MainfoodDetailPageState();
}

class MainfoodDetailPageState extends State<PopularDetailpage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'images/PIZZA.jpg',
                width: double.maxFinite,
                height: MediaQuery.sizeOf(context).height / 2.5,
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
                bottom: -20, // Adjust the bottom position as needed
                left: MediaQuery.of(context).size.width / 2 -
                    240, // Center the container
                child: Container(
                  height: 60,
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
                        Center(child: BigText(text: 'Chinese Slide')),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
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
                    ),
                    SizedBox(
                      height: 200,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.mainColor,
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                        BigText(text: '\$3456' + 'X' + '5'),
                        CircleAvatar(
                          backgroundColor: AppColors.mainColor,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
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

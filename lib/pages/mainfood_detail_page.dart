import 'package:flutter/material.dart';
import 'package:food_app/Controllers/recommended_controller.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/pages/cart_page.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/container_and_icon.dart';
import 'package:food_app/widgets/icon_and_text.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:provider/provider.dart';
import 'package:food_app/Controllers/popular_controller.dart';

class MainfoodDetailPage extends StatefulWidget {
  final Products product;
  const MainfoodDetailPage({
    super.key,
    required this.product,
  });

  @override
  MainfoodDetailPageState createState() => MainfoodDetailPageState();
}

class MainfoodDetailPageState extends State<MainfoodDetailPage> {
  bool isExpanded = false;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                'https://mvs.bslmeiyu.com' '/uploads/${widget.product.img!}',
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
                        Navigator.pop(context);
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
                        Center(child: BigText(text: widget.product.name!)),
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
                      text: widget.product.description!,
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
                          child: IconButton(
                            icon: Icon(Icons.remove, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantity--;
                                }
                              });
                            },
                          ),
                        ),
                        BigText(text: '\$${widget.product.price} X $quantity'),
                        CircleAvatar(
                          backgroundColor: AppColors.mainColor,
                          child: IconButton(
                            icon: Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
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
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        if (quantity > 1) {
                          quantity--;
                          setState(() {});
                        }
                      },
                      icon: Icon(Icons.remove)),
                  BigText(text: '$quantity'),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Provider.of<PopularController>(context, listen: false)
                    .addToCart(widget.product, quantity);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ),
                );
              },
              child: Container(
                height: 60,
                width: 170,
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BigText(
                      text: '\$${widget.product.price! * quantity}',
                      color: Colors.white,
                    ),
                    SmallText(
                      text: 'Add to cart',
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

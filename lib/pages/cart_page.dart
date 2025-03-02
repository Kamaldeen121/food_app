import 'package:flutter/material.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/pages/bottom_navbar_page.dart';
import 'package:food_app/pages/cart_history_page.dart';
import 'package:food_app/pages/main_food_page.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/container_and_icon.dart';
import 'package:food_app/widgets/icon_and_text.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:provider/provider.dart';
import 'package:food_app/Controllers/popular_controller.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<PopularController>(context);
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
                                builder: (context) => BottomNavbarPage()));
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
                itemCount: cartProvider.cartCount,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final cartItem = cartProvider.cartItems[index];
                  final product = cartItem.product;
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
                          child: Image.network(
                            'https://mvs.bslmeiyu.com'
                            '/uploads/${product.img!}',
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
                              child: SizedBox(
                                  width: 200,
                                  child: BigText(text: product.name!)),
                            ),
                            SmallText(
                              text: product.location!,
                              color: Colors.black54,
                            ),
                            Row(
                              children: [
                                BigText(
                                  text: '\$${product.price}',
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
                                      BigText(text: '${cartItem.quantity}'),
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
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Icon(
                Icons.favorite,
                color: AppColors.mainColor,
                size: 30,
              ),
            ),
            GestureDetector(
              onTap: () {
                cartProvider.moveToCartHistory();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartHistoryPage(),
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
                    SmallText(
                      text: 'Checkout',
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

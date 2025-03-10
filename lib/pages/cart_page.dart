import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/pages/bottom_navbar_page.dart';
import 'package:food_app/pages/cart_history_page.dart';
import 'package:food_app/pages/main_food_page.dart';
import 'package:food_app/pages/signin_page.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/container_and_icon.dart';
import 'package:food_app/widgets/icon_and_text.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:provider/provider.dart';
import 'package:food_app/Controllers/popular_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String? loggedInUserPhone;

  @override
  void initState() {
    super.initState();
    _loadUserPhone();
  }

  Future<void> _loadUserPhone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loggedInUserPhone = prefs.getString('phone'); // Retrieve logged-in user
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<PopularController>(context);
    if (cartProvider.cartItem.isNotEmpty) {
      return Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20.r, right: 20.r, top: 40.r),
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
                        width: 60.w,
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
              height: 10.h,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: cartProvider.cartCount,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final cartItem = cartProvider.cartItems[index];
                    final product = cartItem.product;
                    return Container(
                      margin: EdgeInsets.only(
                          left: 10.r, right: 10.r, bottom: 10.r),
                      height: 120.h,
                      width: double.maxFinite,
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
                              width: 130.w,
                              height: 130.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0).r,
                                child: SizedBox(
                                    width: 180.w,
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
                                    width: 10.w,
                                  ),
                                  Container(
                                    height: 40.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
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
          padding: EdgeInsets.all(20).r,
          height: 120.h,
          width: 200.w,
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r)),
                child: Icon(
                  Icons.favorite,
                  color: AppColors.mainColor,
                  size: 30.sp,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (loggedInUserPhone == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Please sign in or sign up to checkout!',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: AppColors.mainColor,
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'Sign In',
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SigninPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    cartProvider.moveToCartHistory();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartHistoryPage(),
                      ),
                    );
                  }
                },
                child: Container(
                  height: 60.h,
                  width: 170.w,
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: SmallText(
                      text: 'Checkout',
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
    return Scaffold(
      body: Center(
        child: BigText(
          text: 'Your cart is empty',
        ),
      ),
    );
  }
}

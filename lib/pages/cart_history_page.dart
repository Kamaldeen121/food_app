import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/Controllers/popular_controller.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/pages/emty_cartpage.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/container_and_icon.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:provider/provider.dart';

class CartHistoryPage extends StatefulWidget {
  const CartHistoryPage({super.key});

  @override
  State<CartHistoryPage> createState() => CartHistoryPageState();
}

class CartHistoryPageState extends State<CartHistoryPage> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<PopularController>(context);
    if (cartProvider.cartHistoryItems.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8).r,
              child: ContainerAndIcon(
                icon: Icons.shopping_cart,
                iconColor: Colors.white,
                color: Colors.amber,
              ),
            )
          ],
          title: BigText(
            text: 'Cart History',
            color: Colors.white,
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20.r),
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: ListView.builder(
            itemCount: cartProvider.cartHistory.length,
            itemBuilder: (context, index) {
              final cartHistoryItem = cartProvider.cartHistory[index];
              return Container(
                margin: EdgeInsets.only(bottom: 20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: cartHistoryItem.dateTime.toString()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          direction: Axis.horizontal,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              height: 70.r,
                              width: 70.r,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Image.network(
                                'https://mvs.bslmeiyu.com/uploads/${cartHistoryItem.product.img}',
                                height: double.maxFinite,
                                width: double.maxFinite,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 120.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SmallText(text: cartHistoryItem.product.name!),
                              BigText(
                                  text: '\$${cartHistoryItem.product.price}'),
                              SmallText(
                                  text:
                                      'Quantity: ${cartHistoryItem.quantity}'),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      );
    } else {
      return EmtyCartpage();
    }
  }
}

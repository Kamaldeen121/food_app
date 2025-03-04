import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/Controllers/popular_controller.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/pages/popular_detailpage.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/icon_and_text.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:provider/provider.dart';

class PopularFoodView extends StatefulWidget {
  const PopularFoodView({
    super.key,
  });

  @override
  State<PopularFoodView> createState() => _PopularFoodViewState();
}

class _PopularFoodViewState extends State<PopularFoodView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PopularController>(context, listen: false)
          .getPopularProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<PopularController>(context);
    return Expanded(
      child: productController.isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: productController.productList!.length,
              itemBuilder: (context, index) {
                final product = productController.productList![index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PopularDetailpage(product: product)));
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 150.h,
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
                            SizedBox(
                              width: 150.w,
                              child: BigText(
                                text: product.name!,
                              ),
                            ),
                            SizedBox(
                              width: 150.w,
                              child: SmallText(
                                text: product.description.toString(),
                                maxLines: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconandText(
                                    icon: Icons.help_rounded,
                                    text: product.typeId.toString(),
                                    iconColor: AppColors.yellowColor,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  SizedBox(
                                    width: 60.w,
                                    child: IconandText(
                                      icon: Icons.location_on,
                                      text: product.price.toString(),
                                      iconColor: AppColors.mainColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  IconandText(
                                    icon: Icons.access_time_sharp,
                                    text: product.stars.toString(),
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

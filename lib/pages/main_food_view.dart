import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/Controllers/popular_controller.dart';
import 'package:food_app/Controllers/recommended_controller.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/pages/mainfood_detail_page.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/icon_and_text.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:provider/provider.dart';

class MainFoodView extends StatefulWidget {
  const MainFoodView({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<MainFoodView> createState() => _MainFoodViewState();
}

class _MainFoodViewState extends State<MainFoodView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RecommendedController>(context, listen: false)
          .getRecommendedProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    print("Screen Width: ${screenSize.width}");
    print("Screen Height: ${screenSize.height}");

    final recommendedController = Provider.of<RecommendedController>(context);
    return SizedBox(
      height: 300.h,
      width: double.maxFinite.w,
      child: recommendedController.isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PageView.builder(
              reverse: false,
              itemCount: recommendedController.productList!.length,
              controller: widget.pageController,
              padEnds: false,
              itemBuilder: (context, index) {
                final recomemdedProduct =
                    recommendedController.productList![index];
                double scale = 2.0;
                if (widget.pageController.position.haveDimensions) {
                  scale =
                      (1 - (widget.pageController.page! - index).abs() * 0.3)
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
                                builder: (context) => MainfoodDetailPage(
                                      product: recomemdedProduct,
                                    )));
                      },
                      child: recommendedController.isLoading == true
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(
                              margin: EdgeInsets.only(
                                left: 10.r,
                              ),
                              height: 250.h,
                              width: double.maxFinite.w,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.r),
                                child: Image.network(
                                  'https://mvs.bslmeiyu.com'
                                  '/uploads/${recomemdedProduct.img!}',
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
                          padding: EdgeInsets.all(20.r),
                          margin: EdgeInsets.only(
                            left: 10.r,
                          ),
                          height: 130.h,
                          width: 250.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: recomemdedProduct.name.toString()),
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
                                    width: 10.w,
                                  ),
                                  SmallText(
                                    text: '4.5',
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  SmallText(
                                    text: '1927',
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  SmallText(
                                    text: recomemdedProduct.name.toString(),
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconandText(
                                    icon: Icons.help_rounded,
                                    text: 'moreeee',
                                    iconColor: AppColors.yellowColor,
                                  ),
                                  IconandText(
                                    icon: Icons.location_on,
                                    text: recomemdedProduct.location.toString(),
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

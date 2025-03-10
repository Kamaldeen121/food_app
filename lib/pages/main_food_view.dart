import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/Controllers/recommended_controller.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/pages/mainfood_detail_page.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/icon_and_text.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MainFoodView extends StatefulWidget {
  const MainFoodView({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<MainFoodView> createState() => _MainFoodViewState();
}

class _MainFoodViewState extends State<MainFoodView> {
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RecommendedController>(context, listen: false)
          .getRecommendedProducts();
    });
    widget.pageController.addListener(() {
      setState(() {
        _currentPage = widget.pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final recommendedController = Provider.of<RecommendedController>(context);

    return Column(
      children: [
        SizedBox(
          height: 300.h,
          width: double.maxFinite,
          child: recommendedController.isloading
              ? _buildShimmerEffect() // Show shimmer while loading
              : PageView.builder(
                  itemCount: recommendedController.productList!.length,
                  controller: widget.pageController,
                  padEnds: false,
                  itemBuilder: (context, index) {
                    final recommendedProduct =
                        recommendedController.productList![index];

                    return Transform(
                      transformHitTests: true,
                      transform: Matrix4.diagonal3Values(1, 1, 1),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainfoodDetailPage(
                                      product: recommendedProduct),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10.r),
                              height: 250.h,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.r),
                                child: Image.network(
                                  'https://mvs.bslmeiyu.com/uploads/${recommendedProduct.img!}',
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
                                margin: EdgeInsets.only(left: 10.r),
                                height: 120.h,
                                width: 250.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(
                                        text:
                                            recommendedProduct.name.toString()),
                                    Row(
                                      children: [
                                        ...List.generate(5, (index) {
                                          return Icon(
                                            Icons.star,
                                            color: AppColors.mainColor,
                                            size: 15,
                                          );
                                        }),
                                        SizedBox(width: 10.w),
                                        SmallText(
                                          text: '4.5',
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.w200,
                                        ),
                                        SizedBox(width: 10.w),
                                        SmallText(
                                          text: '1927',
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.w200,
                                        ),
                                        SizedBox(width: 10.w),
                                        SmallText(
                                          text: recommendedProduct.name
                                              .toString(),
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
                                          text: recommendedProduct.location
                                              .toString(),
                                          iconColor: AppColors.mainColor,
                                        ),
                                        IconandText(
                                          icon: Icons.access_time_sharp,
                                          text: 'Time',
                                          iconColor: AppColors.iconColor1,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // Shimmer Loading Effect
  Widget _buildShimmerEffect() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5, // Number of shimmer placeholders
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: EdgeInsets.only(left: 10.r),
            height: 250.h,
            width: 250.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r),
            ),
          ),
        );
      },
    );
  }
}

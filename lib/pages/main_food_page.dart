import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/Controllers/recommended_controller.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/pages/main_food_view.dart';
import 'package:food_app/pages/popular_food_view.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  final PageController pageController = PageController(viewportFraction: 0.76);
  double _currentPage = 0.0;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPage = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.down,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                padding: EdgeInsets.only(left: 10.r, right: 10.r, top: 40.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(
                          text: 'Bangladesh',
                          color: AppColors.mainColor,
                        ),
                        Row(
                          children: [
                            SmallText(
                              text: 'Nagreeb',
                              fontSize: 13.sp,
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 45.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.search,
                        color: AppColors.iconColor1,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Main Food View (Ensured Fixed Height)
              SizedBox(
                height: 300.h,
                child: MainFoodView(pageController: pageController),
              ),

              SizedBox(height: 10.h),

              Consumer<RecommendedController>(
                builder: (BuildContext context, recController, child) {
                  return recController.isloading
                      ? _buildShimmerDots() // Show shimmer instead of CircularProgressIndicator
                      : recController.productList != null &&
                              recController.productList!.isNotEmpty
                          ? Center(
                              child: DotsIndicator(
                                reversed: false,
                                dotsCount: recController.productList!.length,
                                position: _currentPage,
                                decorator: DotsDecorator(
                                  activeColor: AppColors.mainColor,
                                  size: const Size.square(9.0),
                                  activeSize: const Size(18.0, 9.0),
                                  activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            )
                          : Container(); // Show nothing if productList is empty
                },
              ),

              SizedBox(height: 10.h),

              // Popular Food Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.r),
                child: Row(
                  children: [
                    BigText(text: 'Popular'),
                    SizedBox(width: 10.w),
                    SmallText(text: '.'),
                    SizedBox(width: 10.w),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SmallText(
                        text: 'Food following',
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10.h),

              // Popular Food View (Ensured Fixed Height)
              PopularFoodView(),
            ],
          ),
        ),
      ),
    );
  }

  // Shimmer Effect for DotsIndicator
  Widget _buildShimmerDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5, // Number of dots
        (index) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            width: 9.0,
            height: 9.0,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

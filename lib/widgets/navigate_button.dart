import 'package:flutter/material.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/widgets/big_text.dart';

class NavigateButton extends StatelessWidget {
  final String navigateText;
  final double? height;
  final double? width;
  const NavigateButton({
    super.key,
    required this.navigateText,
    this.height = 60,
    this.width = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: AppColors.mainColor, borderRadius: BorderRadius.circular(30)),
      child: Center(
          child: BigText(
        text: navigateText,
        color: Colors.white,
        fontSize: 25,
      )),
    );
  }
}

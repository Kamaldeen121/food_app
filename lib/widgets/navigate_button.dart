import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/widgets/big_text.dart';

class NavigateButton extends StatelessWidget {
  final String navigateText;
  final double? height;
  final double? width;
  final VoidCallbackAction? callbackAction;
  final void Function()? onTap;

  const NavigateButton({
    super.key,
    this.onTap,
    this.callbackAction,
    required this.navigateText,
    this.height = 60,
    this.width = 200,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.circular(30)),
        child: Center(
            child: BigText(
          text: navigateText,
          color: Colors.white,
          fontSize: 25,
        )),
      ),
    );
  }
}

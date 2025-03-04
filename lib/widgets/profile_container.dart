import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/widgets/big_text.dart';

class ProfileContainer extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const ProfileContainer({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10),
        height: 75,
        width: double.maxFinite,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 10,
              offset: Offset(1, 7),
              color: Colors.grey.withOpacity(0.5))
        ], borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              minRadius: 25,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10.r,
            ),
            BigText(
              text: text,
              fontSize: 13.r,
            )
          ],
        ));
  }
}

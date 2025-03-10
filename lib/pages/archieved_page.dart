import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/pages/signin_page.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/navigate_button.dart';

class ArchievedPage extends StatefulWidget {
  const ArchievedPage({super.key});

  @override
  State<ArchievedPage> createState() => _EmptyProfilepageState();
}

class _EmptyProfilepageState extends State<ArchievedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          centerTitle: true,
          title: BigText(
            text: 'Archieved',
            color: Colors.white,
          ),
        ),
        body: Center(
          child: BigText(
            text: 'Nothing is archieved',
            fontSize: 30.sp,
            color: AppColors.mainColor,
          ),
        ));
  }
}

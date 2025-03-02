import 'package:flutter/material.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/profile_container.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: BigText(
          text: 'Profile',
          color: Colors.white,
        ),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            CircleAvatar(
              maxRadius: 120,
              backgroundColor: AppColors.mainColor,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 120,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileContainer(
                      icon: Icons.person,
                      text: 'Kamal',
                      color: AppColors.mainColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ProfileContainer(
                      icon: Icons.phone,
                      text: '34343423423525',
                      color: AppColors.yellowColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ProfileContainer(
                      icon: Icons.email,
                      text: 'kamal@gmail.com',
                      color: AppColors.yellowColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ProfileContainer(
                      icon: Icons.location_on_outlined,
                      text: 'Fill your location',
                      color: AppColors.yellowColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ProfileContainer(
                      icon: Icons.message,
                      text: 'Messages',
                      color: Colors.red,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ProfileContainer(
                      icon: Icons.logout,
                      text: 'LogOut',
                      color: Colors.red,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

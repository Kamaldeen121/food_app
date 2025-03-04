import 'package:flutter/material.dart';
import 'package:food_app/Controllers/signin_controller.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/models/signin_payload.dart';
import 'package:food_app/pages/empty_profilepage.dart';
import 'package:food_app/pages/signup_page.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/profile_container.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Provider.of<LoginController>(context, listen: false).loginUser(
        SigninPayload('name', 'email', phone: 'phone', password: 'password'));
  }

  @override
  Widget build(BuildContext context) {
    final loginController =
        Provider.of<LoginController>(context, listen: false);
    if (loginController.isLoggedIn == true) {
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
        body: Consumer<LoginController>(
            builder: (BuildContext context, loginController, child) {
          final user = loginController.loginUsers;

          return Container(
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
                          icon: Icons.email,
                          text: user?.email ?? 'No name',
                          color: AppColors.mainColor,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ProfileContainer(
                          icon: Icons.phone,
                          text: user?.phone ?? 'No phone',
                          color: AppColors.yellowColor,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ProfileContainer(
                          icon: Icons.person,
                          text: user?.name ?? ' No email',
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
                        GestureDetector(
                          onTap: () {
                            if (loginController.isLoggedIn == true) {
                              loginController.logoutUser();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupPage()));
                            } else {
                              loginController.isLoggedIn == false;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('No user logged in'),
                                  backgroundColor: AppColors.mainColor,
                                ),
                              );
                            }
                          },
                          child: ProfileContainer(
                            icon: Icons.logout,
                            text: 'LogOut',
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      );
    } else {
      return Center(child: EmptyProfilepage());
    }
  }
}

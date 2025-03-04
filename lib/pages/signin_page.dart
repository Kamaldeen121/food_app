import 'package:flutter/material.dart';
import 'package:food_app/Controllers/signin_controller.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/models/signin_payload.dart';
import 'package:food_app/pages/bottom_navbar_page.dart';
import 'package:food_app/pages/signup_page.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/custom_textfield.dart';
import 'package:food_app/widgets/navigate_button.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'images/attachment_126252018.png',
                width: 200,
                height: 180,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BigText(
                        text: 'Hello',
                        fontSize: 70,
                      ),
                    ],
                  ),
                  SmallText(text: 'Sign into your account'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: phoneController,
                prefixIcon: Icons.phone,
                hintText: 'Phone',
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: passwordController,
                prefixIcon: Icons.password,
                hintText: 'Password',
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: nameController,
                prefixIcon: Icons.person,
                hintText: 'Name',
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: emailController,
                prefixIcon: Icons.email,
                hintText: 'email',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SmallText(text: 'Sign into your account'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<LoginController>(
                builder: (BuildContext context, loginController, child) {
                  return loginController.isLoading
                      ? CircularProgressIndicator()
                      : NavigateButton(
                          navigateText: 'Sign In',
                          onTap: () async {
                            if (phoneController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('All fields are required'),
                                  backgroundColor: AppColors.mainColor,
                                ),
                              );
                            } else {
                              final user = SigninPayload(
                                  phone: phoneController.text.trim(),
                                  password: passwordController.text.trim(),
                                  emailController.text.trim(),
                                  nameController.text.trim());
                              await loginController.loginUser(user);

                              if (loginController.isLoggedIn) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavbarPage()));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      Text(loginController.responseMessage),
                                  backgroundColor: AppColors.mainColor,
                                ));
                              }
                            }
                          },
                        );
                },
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
                },
                child: SmallText(text: 'Dont have an account? Create'),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool obsecureText = true;

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
                width: 200.w,
                height: 180.h,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20.h),
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
              SizedBox(height: 20.h),
              CustomTextField(
                controller: phoneController,
                prefixIcon: Icons.phone,
                hintText: 'Phone',
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                controller: passwordController,
                prefixIcon: Icons.password,
                hintText: 'Password',
                obscureText: obsecureText,
                suffixIcon:
                    obsecureText ? Icons.visibility_off : Icons.visibility,
                onSuffixTap: () {
                  setState(() {
                    obsecureText = !obsecureText;
                  });
                },
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SmallText(text: 'Forgot password?'),
                ],
              ),
              SizedBox(height: 20),
              Consumer<LoginController>(
                builder: (BuildContext context, loginController, child) {
                  return GestureDetector(
                    onTap: loginController.isLoading
                        ? null
                        : () async {
                            if (phoneController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Phone and password required'),
                                  backgroundColor: AppColors.mainColor,
                                ),
                              );
                            } else {
                              final user = SigninPayload(
                                '', // Name (will be loaded from SharedPreferences)
                                '', // Email (will be loaded from SharedPreferences)
                                phone: phoneController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                              await loginController.loginUser(user);

                              if (loginController.isLoggedIn) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BottomNavbarPage(),
                                  ),
                                );
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
                    child: Container(
                      height: 60.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      alignment: Alignment.center,
                      child: loginController.isLoading
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  );
                },
              ),
              SizedBox(height: 30.h),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
                },
                child: SmallText(text: 'Don’t have an account? Create one'),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

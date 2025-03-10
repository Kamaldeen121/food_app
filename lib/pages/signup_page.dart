import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/Controllers/signup_controller.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/models/signup_payload.dart';
import 'package:food_app/pages/signin_page.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/custom_textfield.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
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
        padding: EdgeInsets.only(top: 40.r, left: 20.r, right: 20).r,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      'images/attachment_126252018.png',
                      width: 200.w,
                      height: 150.w,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      controller: emailController,
                      prefixIcon: Icons.email_sharp,
                      hintText: 'Email',
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      controller: passwordController,
                      prefixIcon: Icons.password,
                      hintText: 'Password',
                      obscureText: obsecureText,
                      suffixIcon: obsecureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      onSuffixTap: () {
                        setState(() {
                          obsecureText = !obsecureText;
                        });
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      controller: nameController,
                      prefixIcon: Icons.person,
                      hintText: 'Name',
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      controller: phoneController,
                      prefixIcon: Icons.phone,
                      hintText: 'Phone',
                    ),
                    SizedBox(height: 50.h),
                    Consumer<SignupController>(
                      builder: (BuildContext context, signupController, child) {
                        return GestureDetector(
                          onTap: signupController.isloading
                              ? null
                              : () async {
                                  final email = emailController.text.trim();
                                  final password =
                                      passwordController.text.trim();
                                  final name = nameController.text.trim();
                                  final phone = phoneController.text.trim();

                                  if (email.isEmpty ||
                                      password.isEmpty ||
                                      name.isEmpty ||
                                      phone.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('All fields are required'),
                                        backgroundColor: AppColors.mainColor,
                                      ),
                                    );
                                  } else {
                                    final newUser = SignupPayload(
                                      name: name,
                                      phone: phone,
                                      email: email,
                                      password: password,
                                    );
                                    await signupController
                                        .registerUser(newUser);
                                    if (signupController.isRegister) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SigninPage(),
                                        ),
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              signupController.responseMessage),
                                          backgroundColor: AppColors.mainColor,
                                        ),
                                      );
                                    }
                                  }
                                },
                          child: Container(
                            height: 60.h,
                            width: 200.w,
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            child: signupController.isloading
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                : Text(
                                    'Sign Up',
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
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SigninPage()));
                      },
                      child: SmallText(text: 'Already have an account?'),
                    ),
                    SizedBox(height: 50.h),
                    SmallText(text: 'Sign Up Using The following Methods'),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          child: Image.asset(
                            'images/fb.png',
                            width: 40.h,
                            height: 40,
                          ),
                        ),
                        SizedBox(width: 10),
                        CircleAvatar(
                          child: Image.asset(
                            'images/insta.png',
                            width: 40.w,
                            height: 40.h,
                          ),
                        ),
                        SizedBox(width: 10),
                        CircleAvatar(
                          child: Image.asset(
                            'images/twitter.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

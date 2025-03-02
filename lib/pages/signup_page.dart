import 'package:flutter/material.dart';
import 'package:food_app/app_colors.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/custom_textfield.dart';
import 'package:food_app/widgets/navigate_button.dart';
import 'package:food_app/widgets/small_text.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Expanded(
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
                CustomTextField(
                  prefixIcon: Icons.email_sharp,
                  hintText: 'Email',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  prefixIcon: Icons.password,
                  hintText: 'Password',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  prefixIcon: Icons.person,
                  hintText: 'Name',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  prefixIcon: Icons.phone,
                  hintText: 'Phone',
                ),
                SizedBox(
                  height: 50,
                ),
                NavigateButton(
                  navigateText: 'Sign Up',
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SmallText(text: 'Alraedy have an account?')),
                SizedBox(
                  height: 50,
                ),
                SmallText(text: 'Sign Up Using The following Methods'),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Image.asset(
                        'images/fb.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      child: Image.asset(
                        'images/insta.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
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
      ),
    );
  }
}

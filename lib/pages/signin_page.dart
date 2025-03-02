import 'package:flutter/material.dart';
import 'package:food_app/pages/signup_page.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/custom_textfield.dart';
import 'package:food_app/widgets/navigate_button.dart';
import 'package:food_app/widgets/small_text.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
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
                  height: 10,
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
                SizedBox(
                  height: 50,
                ),
                NavigateButton(
                  navigateText: 'Sign In',
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                    child: SmallText(text: 'Dont have an accont? Create')),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

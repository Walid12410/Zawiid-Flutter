import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Authentication/SignUp.dart';
import 'package:zawiid/Authentication/Widget/SignInButton.dart';
import 'package:zawiid/Authentication/Widget/SignInTextfield.dart';
import 'package:zawiid/Authentication/Widget/Terms&PrivacySignIn.dart';
import 'package:zawiid/Color&Icons/color.dart';

import 'Widget/ForgetPassword.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: tdGreen,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Image.asset(
                                  'assets/log/LOGO-icon---Black.png',
                                  width: screenWidth * 0.8,
                                  height: screenHeight * 0.24,
                                  fit: BoxFit.contain,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          const Text(
                            'Log In',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: tdBlack,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.push(context.namedLocation('SignUp'));
                              },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 25, color: tdGrey),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          SignInTextFieldWidget(),
                          SizedBox(height: screenHeight * 0.03),
                          SignInButton(),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          ForgetPasswordWidget()
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        elevation: 0,
        color: tdGreen,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: TermsAndPrivacySignIn(),
        ),
      ),
    );
  }
}


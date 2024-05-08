import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Authentication/SignIn.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'Widget/SignUpButton.dart';
import 'Widget/SignUpTextfield.dart';
import 'Widget/Terms&PrivacySignUp.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>{

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: tdBlack,
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
                                  'assets/log/LOGO-icon---green.png',
                                  width: screenWidth * 0.8,
                                  height: screenHeight * 0.24,
                                  fit: BoxFit.contain,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                           Text(
                            'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.06,
                              color: tdWhite,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.push(context.namedLocation('SignIn'));
                            },
                            child:  Text(
                              'Log In',
                              style: TextStyle(fontSize: screenWidth * 0.06, color: tdGrey),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          TextFieldWidgetSignUp(),
                          SizedBox(height: screenHeight * 0.03),
                          SignUpButton(),
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
      bottomNavigationBar:const BottomAppBar(
        elevation: 0, // Remove the shadow
        color: tdBlack,
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: TermsAndPrivacySignUp(),
        ),
      ),
    );
  }
}

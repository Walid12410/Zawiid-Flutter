import 'package:flutter/material.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInTextFieldWidget extends StatelessWidget {
  const SignInTextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: tdWhite,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  labelText: 'EMAIL',
                  labelStyle: const TextStyle(fontSize: 15, color: tdGrey),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right:  20),
                    child: SvgPicture.asset('assets/svg/001-mail.svg',
                      width: screenWidth * 0.02,height: screenHeight *0.02,),
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  labelText: 'PASSWORD',
                  labelStyle: const TextStyle(fontSize: 15, color: tdGrey),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right:  20),
                    child: SvgPicture.asset('assets/svg/002-password.svg',
                    width: screenWidth * 0.02,height: screenHeight * 0.02,),
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

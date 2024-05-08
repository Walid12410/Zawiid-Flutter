import 'package:flutter/material.dart';
import 'package:zawiid/Color&Icons/color.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(1),
      child: GestureDetector(
        onTap: () {
          //signup
        },
        child: Container(
          width: double.infinity,
          height: screenHeight *0.06,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: tdWhite),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: screenWidth * 0.05,),
                 Text(
                  'SIGN UP',
                  style: TextStyle(
                      fontSize: screenWidth * 0.034,
                      fontWeight: FontWeight.bold,
                      color: tdBlack),
                ),
                Container(
                    width: screenWidth * 0.09,
                    height: screenWidth * 0.09,
                    decoration: BoxDecoration(
                        color: tdBlack,
                        borderRadius: BorderRadius.circular(20)),
                    child:  Icon(
                      Icons.arrow_forward_ios,
                      size: screenWidth * 0.05,
                      color: tdGreen,
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
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
          GoRouter.of(context).go("/home");
        },
        child: Container(
          width: double.infinity,
          height: screenHeight *0.06,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: tdBlack),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(''),
                const Text(
                  'LOG IN',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: tdWhite),
                ),
                Container(
                    width: screenWidth * 0.09,
                    height: screenWidth * 0.09,
                    decoration: BoxDecoration(
                        color: tdWhite,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
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

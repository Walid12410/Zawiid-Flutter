import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../Color&Icons/color.dart';

class OptionsCard extends StatelessWidget {
  const OptionsCard({super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.icon1,
    required this.text1,
    required this.icon2,
    required this.text2});

  final double screenHeight;
  final double screenWidth;
  final IconData icon1;
  final IconData icon2;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: tdWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                GoRouter.of(context).go('/CustomerPage');
              },
              child: ListTile(
                leading: Icon(icon1),
                title: Text(
                  text1,
                  style: TextStyle(
                      color: tdGrey,
                      fontSize: screenWidth * 0.034,
                      fontWeight: FontWeight.bold),
                ),
                trailing: Container(
                  width: screenWidth * 0.06,
                  height: screenWidth * 0.06,
                  decoration: BoxDecoration(
                    color: tdWhiteNav,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:  Icon(
                    Icons.arrow_forward_ios,
                    size: screenWidth * 0.033,
                    color: tdGrey,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 50, right: 20),
              child: Divider(
                color: tdGrey,
                thickness: 0.2,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: Icon(icon2),
                title: Text(
                  text2,
                  style: TextStyle(
                      color: tdGrey,
                      fontSize: screenWidth * 0.034,
                      fontWeight: FontWeight.bold),
                ),
                trailing: Container(
                  width: screenWidth * 0.06,
                  height: screenWidth * 0.06,
                  decoration: BoxDecoration(
                    color: tdWhiteNav,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: screenWidth * 0.033,
                    color: tdGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

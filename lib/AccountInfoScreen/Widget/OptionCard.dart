import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../Color&Icons/color.dart';

class OptionsCard extends StatelessWidget {
  const OptionsCard(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.icon1,
      required this.text1,
      required this.icon2,
      required this.text2,
      required this.onTap1,
      required this.onTap2,
      required this.isWhatsapp});

  final double screenHeight;
  final double screenWidth;
  final String icon1;
  final String icon2;
  final String text1;
  final String text2;
  final VoidCallback onTap1;
  final VoidCallback onTap2;
  final bool isWhatsapp;

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
              onTap: onTap1,
              child: ListTile(
                leading: SvgPicture.asset(icon1),
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
                  child: Icon(
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
              onTap: onTap2,
              child: ListTile(
                  leading: SvgPicture.asset(icon2),
                  title: Text(
                    text2,
                    style: TextStyle(
                        color: tdGrey,
                        fontSize: screenWidth * 0.034,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: isWhatsapp
                      ? SizedBox(
                          width: screenWidth * 0.06,
                          height: screenWidth * 0.09,
                          child: SvgPicture.asset(
                            'assets/svg-profile/whatsapp.svg',
                            color: tdGreen,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
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
                        )),
            ),
          ],
        ),
      ),
    );
  }
}

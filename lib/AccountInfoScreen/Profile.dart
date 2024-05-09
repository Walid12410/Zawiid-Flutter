import 'package:flutter/material.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'Widget/LogOut.dart';
import 'Widget/OptionCard.dart';
import 'Widget/ProfileHeadPage.dart';
import 'Widget/UserProfileCard.dart';

class ProfileMain extends StatefulWidget {
  const ProfileMain({super.key});

  @override
  State<ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.01),
                ProfileHeadPage(
                    screenWidth: screenWidth, screenHeight: screenHeight),
                SizedBox(
                  height: screenHeight * 0.06,
                ),
                UserProfileCard(
                    screenHeight: screenHeight, screenWidth: screenWidth),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                OptionsCard(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    icon1: Icons.shopping_bag_outlined,
                    text1: 'All My Orders',
                    icon2: Icons.headset,
                    text2: 'Customer Support'),
                OptionsCard(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    icon1: Icons.location_on_sharp,
                    text1: 'Shipping Address',
                    icon2: Icons.translate,
                    text2: 'Language'),
                OptionsCard(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    icon1: Icons.privacy_tip_outlined,
                    text1: 'Privacy Policy',
                    icon2: Icons.event_note_outlined,
                    text2: 'Legal information'),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                LogoutWidget(
                    screenWidth: screenWidth, screenHeight: screenHeight)
              ],
            ),
          ),
        ),
      ),
    );
  }
}





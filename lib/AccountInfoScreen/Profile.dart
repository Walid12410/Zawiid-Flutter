import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8).w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 5.h),
                const ProfileHeadPage(),
                SizedBox(
                  height: 30.h,
                ),
                const UserProfileCard(),
                SizedBox(height: 10.h,),
                OptionsCard(
                    icon1: 'assets/svg-profile/icons.svg',
                    text1: 'All My Orders',
                    icon2: 'assets/svg-profile/icon.svg',
                    text2: 'Customer Support',
                    onTap1: (){
                      context.goNamed("OrderView");
                    },
                  onTap2: (){
                    context.push(context.namedLocation('CustomerPage'));
                  },
                  isWhatsapp: true,
                ),
                OptionsCard(
                    icon1: 'assets/svg-profile/shipping.svg',
                    text1: 'Shipping Address',
                    icon2: 'assets/svg-profile/language.svg',
                    text2: 'Language',
                  onTap1: (){
                    context.goNamed("AddressView");
                  },
                  onTap2: (){
                    context.push(context.namedLocation('CustomerPage'));
                  },
                  isWhatsapp: false,
                ),
                OptionsCard(
                    icon1: 'assets/svg-profile/Group.svg',
                    text1: 'Privacy Policy',
                    icon2: 'assets/svg-profile/Path.svg',
                    text2: 'Legal information',
                  onTap1: (){
                    context.push(context.namedLocation('PrivacyPage'));
                  },
                  onTap2: (){
                    context.push(context.namedLocation('TermsOfServices'));
                  },
                  isWhatsapp: false,
                ),
                SizedBox(
                  height: 10.h,
                ),
                const LogoutWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}





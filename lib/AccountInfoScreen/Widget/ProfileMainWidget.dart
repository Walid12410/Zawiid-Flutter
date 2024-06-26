import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'LogOut.dart';
import 'OptionCard.dart';
import 'ProfileHeadPage.dart';
import 'UserProfileCard.dart';

class ProfileMainWidget extends StatelessWidget {
  const ProfileMainWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 5.h),
        const ProfileHeadPage(),
        SizedBox(
          height: 30.h,
        ),
        const UserProfileCard(),
        SizedBox(
          height: 10.h,
        ),
        OptionsCard(
          icon1: 'assets/svg-profile/icons.svg',
          text1: 'All My Orders',
          icon2: 'assets/svg-profile/icon.svg',
          text2: 'Customer Support',
          onTap1: () {
            context.goNamed("OrderView");
          },
          onTap2: () {
            context.push(context.namedLocation('CustomerPage'));
          },
          isWhatsapp: true,
        ),
        OptionsCard(
          icon1: 'assets/svg-profile/shipping.svg',
          text1: 'Shipping Address',
          icon2: 'assets/svg-profile/language.svg',
          text2: 'Language',
          onTap1: () {
            context.goNamed("AddressView");
          },
          onTap2: () {
            context.push(context.namedLocation('CustomerPage'));
          },
          isWhatsapp: false,
        ),
        OptionsCard(
          icon1: 'assets/svg-profile/Group.svg',
          text1: 'Privacy Policy',
          icon2: 'assets/svg-profile/Path.svg',
          text2: 'Legal information',
          onTap1: () {
            context.push(context.namedLocation('PrivacyPage'));
          },
          onTap2: () {
            context
                .push(context.namedLocation('TermsOfServices'));
          },
          isWhatsapp: false,
        ),
        SizedBox(
          height: 10.h,
        ),
        const LogoutWidget()
      ],
    );
  }
}

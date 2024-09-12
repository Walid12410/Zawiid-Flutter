import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Widget/LanguageChange.dart';
import 'package:zawiid/generated/l10n.dart';
import 'LogOut.dart';
import 'OptionCard.dart';
import 'ProfileHeadPage.dart';
import 'UserProfileCard.dart';
import 'package:intl/intl.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}


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
          text1: S.of(context).allMyOrders,
          icon2: 'assets/svg-profile/icon.svg',
          text2: S.of(context).customerSupport,
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
          text1: S.of(context).shippingAddress,
          icon2: 'assets/svg-profile/language.svg',
          text2: S.of(context).language,
          onTap1: () {
            context.goNamed("AddressView");
          },
          onTap2: () {
            showDialog(
              context: context,
              builder: (context) => const LanguageChangeDialog(),
            );
          },
          isWhatsapp: false,
        ),
        OptionsCard(
          icon1: 'assets/svg-profile/Group.svg',
          text1: S.of(context).privacyPolicy,
          icon2: 'assets/svg-profile/Path.svg',
          text2: S.of(context).legalInformation,
          onTap1: () {
            context.push(context.namedLocation('PrivacyPage'));
          },
          onTap2: () {
            context.push(context.namedLocation('TermsOfServices'));
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

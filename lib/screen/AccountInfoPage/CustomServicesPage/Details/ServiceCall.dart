import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/localization/generated/l10n.dart';
import 'package:zawiid/provider/AppSetting_Provider.dart';

class ServiceCallUs extends StatelessWidget {
  const ServiceCallUs({
    super.key,
  });

  Future<void> _launchDialer(String phoneNumber) async {
    try {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      await launchUrl(launchUri);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<SettingsProvider>(context, listen: true);
    var appSetting = setting.settings.first;

    return Padding(
      padding: const EdgeInsets.all(5).w,
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: tdWhite,
          borderRadius: BorderRadius.circular(15).w,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(0, 0),
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(3).w,
              child: SizedBox(
                height: 35.h,
                width: 35.w,
                child: Image.asset(
                  'assets/img/CustomerService/Group.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0).w,
              child: GestureDetector(
                onTap: () {
                  _launchDialer(appSetting.phoneNumber);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: tdWhiteNav,
                      borderRadius: BorderRadius.circular(20).w),
                  child: Padding(
                    padding: const EdgeInsets.all(5).w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          S.of(context).callUs,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp,
                              color: tdBlack),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(
                          appSetting.phoneNumber,
                          style: TextStyle(
                              color: tdBlue,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

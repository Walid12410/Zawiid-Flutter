import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zawiid/Api/EmailService.dart';
import 'package:zawiid/Widget/Toast/ToastError.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/provider/AppSetting_Provider.dart';

class ServiceOptionCard extends StatelessWidget {
  const ServiceOptionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<SettingsProvider>(context, listen: true);
    var appSetting = setting.settings.first;

    return Padding(
      padding: const EdgeInsets.all(5.0).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
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
            child: Padding(
              padding: const EdgeInsets.all(12).w,
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: 52.h,
                    width: 71.w,
                    child: Image.asset(
                      'assets/img/CustomerService/mail.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  GestureDetector(
                    onTap: () {
                      EmailService service = EmailService();
                      service.sendEmailSupport(appSetting.email);
                    },
                    child: Container(
                      width: 140.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20).w,
                          color: tdWhiteNav),
                      child: Center(
                        child: Text(
                          S.of(context).emailUs,
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: tdBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
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
            child: Padding(
              padding: const EdgeInsets.all(12).w,
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: 54.h,
                    width: 74.w,
                    child: Image.asset(
                      'assets/img/CustomerService/speech.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 5.sp),
                  GestureDetector(
                    onTap: () async {
                      final String phone = appSetting
                          .phoneNumber; // Make sure this includes country code
                      final Uri whatsappUrl = Uri.parse(
                          "https://wa.me/${phone.replaceAll('+', '')}");
                      if (await canLaunchUrl(whatsappUrl)) {
                        await launchUrl(whatsappUrl,
                            mode: LaunchMode.externalApplication);
                      } else {
                        showToast(S.of(context).errorConnection);
                      }
                    },
                    child: Container(
                      width: 140.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20).w,
                          color: tdWhiteNav),
                      child: Center(
                        child: Text(
                          S.of(context).chatNow,
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: tdBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

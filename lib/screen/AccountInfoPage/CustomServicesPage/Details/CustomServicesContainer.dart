import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/localization/generated/l10n.dart';
import 'optionContainer.dart';

class CustomServicesContainer extends StatelessWidget {
  const CustomServicesContainer({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2).w,
      child: Container(
        decoration: const BoxDecoration(
          color: tdWhiteNav,
        ),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            SizedBox(
                width: 150.w,
                height: 120.h,
                child: Image.asset(
                    'assets/img/CustomerService/CustomerServices.png',
                    fit: BoxFit.fill)),
            SizedBox(height: 20.h),
            Text(
              S.of(context).tellUsHowToHelp,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.w,
                color: tdBlack,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5.h),
            const OptionContainer(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/localization/generated/l10n.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1).w,
      child: GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Container(
          width: double.infinity,
          height: 35.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50).w, color: tdWhite),
          child: Padding(
            padding: const EdgeInsets.all(5).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 30.w),
                Text(
                  S.of(context).signUps,
                  style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                      color: tdBlack),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: isArabic()
                      ? const EdgeInsets.only(left: 8).w
                      : const EdgeInsets.only(right: 8).w,
                  child: Container(
                    width: 22.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                        color: tdBlack,
                        borderRadius: BorderRadius.circular(200).w),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 10.w,
                      color: tdGreen,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

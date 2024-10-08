import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/localization/generated/l10n.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

class AddAddressBottom extends StatelessWidget {
  const AddAddressBottom({super.key, required this.showCheckOut});

  final bool showCheckOut;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isArabic()
          ? const EdgeInsets.only(left: 20).w
          : const EdgeInsets.only(right: 20).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              if (showCheckOut == true) {
                context.push(context.namedLocation('addAddress2'));
              } else {
                context.goNamed("AddAddressPage");
              }
            },
            child: Icon(
              Icons.add_circle_outline,
              size: 15.w,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (showCheckOut == true) {
                context.push(context.namedLocation('addAddress2'));
              } else {
                context.goNamed("AddAddressPage");
              }
            },
            child: Text(
              S.of(context).addAddress,
              style: TextStyle(
                  fontSize: 10.sp, fontWeight: FontWeight.bold, color: tdGrey),
            ),
          )
        ],
      ),
    );
  }
}

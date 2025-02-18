import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/generated/l10n.dart';

class AddAddressHead extends StatelessWidget {
  const AddAddressHead({super.key, required this.isCheckOut});

  final int isCheckOut;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (isCheckOut == 1) {
                context.push(context.namedLocation('shippingAddress'));
              } else {
                GoRouter.of(context).goNamed("AddressView");
              }
            },
            child: SizedBox(
              width: 20.w,
              height: 18.h,
              child: Image.asset('assets/img/pop.png', fit: BoxFit.contain),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10).w,
            child: Text(S.of(context).addAddress,
                style: TextStyle(
                    color: tdBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp)),
          ),
          SizedBox(
            width: 20.w,
          )
        ],
      ),
    );
  }
}

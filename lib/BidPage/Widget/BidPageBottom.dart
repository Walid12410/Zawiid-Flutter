import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Color&Icons/color.dart';

class BidPageBottom extends StatelessWidget {
  const BidPageBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 30.h,
        width: 250.w,
        decoration: BoxDecoration(
          color: tdBlack,
          borderRadius: BorderRadius.circular(50).w,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 160.w,
              decoration: BoxDecoration(
                color: tdWhite,
                borderRadius: BorderRadius.circular(50).w,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5).w,
                  child: TextField(
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d{0,9}(\.\d{0,4})?$')),
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Bid Price',
                      hintStyle: TextStyle(fontSize: 10.sp, color: tdGrey),
                    ),
                    style: TextStyle(fontSize: 10.sp, color: tdBlack),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Container(
              width: 80.w,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ).w,
                color: tdBlack,
              ),
              child: Center(
                child: Text(
                  'Bid Now',
                  style: TextStyle(fontSize: 8.sp, color: tdWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

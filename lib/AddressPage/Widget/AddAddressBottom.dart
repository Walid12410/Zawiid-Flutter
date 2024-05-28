import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../Color&Icons/color.dart';

class AddAddressBottom extends StatelessWidget {
  const AddAddressBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: (){
              context.goNamed("AddAddressPage");
            },
            child: Icon(
              Icons.add_circle_outline,
              size: 15.w,
            ),
          ),
          GestureDetector(
            onTap: (){
              context.goNamed("AddAddressPage");
            },
            child: Text(
              'ADD ADDRESS',
              style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: tdGrey),
            ),
          )
        ],
      ),
    );
  }
}

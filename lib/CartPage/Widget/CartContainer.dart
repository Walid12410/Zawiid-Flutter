import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';

class CartContainer extends StatelessWidget {
  const CartContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8).w,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 95.w,
                  height: 100.h,
                  child: Image.asset('assets/img/iphone.png',fit: BoxFit.fill,),
                ),
                SizedBox(
                  width: 130.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('SAMSUNG GALAXY S24',style: TextStyle(
                        fontSize: 12.sp,color: tdBlack,fontWeight: FontWeight.bold,
                      ),overflow: TextOverflow.ellipsis,),
                      SizedBox(
                        width: 90.h,
                        child: Text('Ultra, 128GB Ram + 350 storage ',style: TextStyle(
                          fontSize: 12.sp,color: tdBlack,fontWeight: FontWeight.bold,
                        ),overflow: TextOverflow.ellipsis,),
                      ),
                      SizedBox(height: 5.h),
                      Text('358.000 KB',style: TextStyle(fontWeight: FontWeight.bold,color:tdBlack,fontSize: 15.sp ),),
                      SizedBox(height: 5.h),
                      Text('SKU: FT00962',style: TextStyle(fontSize: 6.sp,color: tdGrey),)
                    ],
                  ),
                ),
                Container(
                  height: 20.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50).w,
                    color: tdWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 5,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: (){},
                          child: Text('-',style: TextStyle(
                              fontSize: 18.sp,color: tdBlack
                          ),),
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: Text('+',style: TextStyle(
                              fontSize: 18.sp,color: tdBlack
                          ),),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 5.h,),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

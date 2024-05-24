import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';

class CartContainer extends StatelessWidget {
  const CartContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 90.w,
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
                        fontSize: 10.sp,color: tdBlack,fontWeight: FontWeight.bold,
                      ),overflow: TextOverflow.ellipsis,),
                      SizedBox(
                        width: 90.h,
                        child: Text('Ultra, 128GB Ram + 350 storage ',style: TextStyle(
                          fontSize: 10.sp,color: tdBlack,fontWeight: FontWeight.bold,
                        ),overflow: TextOverflow.ellipsis,),
                      ),
                      SizedBox(height: 5.h),
                      Text('358.000 KB',style: TextStyle(fontWeight: FontWeight.bold,color:tdBlack,fontSize: 12.sp ),),
                      SizedBox(height: 5.h),
                      Text('SKU: FT00962',style: TextStyle(fontSize: 4.sp,color: tdGrey),)
                    ],
                  ),
                ),
                SizedBox(width: 30.w),
                Container(
                  height: 20.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50).w,
                    color: tdWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
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
                          child: Icon(Icons.remove,color: tdGrey,size: 12.w,)
                        ),
                        GestureDetector(
                          onTap: (){},
                            child: Icon(Icons.add,color: tdGrey,size: 12.w,)
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
      );
  }
}

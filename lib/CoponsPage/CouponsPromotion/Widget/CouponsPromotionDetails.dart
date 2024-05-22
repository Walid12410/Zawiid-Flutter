import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../Color&Icons/color.dart';
import 'CouponsPromotionTable.dart';


class CouponsPromotionDetails extends StatelessWidget {
  const CouponsPromotionDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(10).w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            height: 80.h,
            child: Image.asset(
              'assets/img/adidas.png',
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Text(
                'Adidas',
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: tdBlack),
              ),
              Text(
                ' Coupon & Promo Codes - April 2024',
                style: TextStyle(fontSize: 13.sp, color: tdGrey),
              ),
            ],
          ),
          Text(
            'adidas.com.kw',
            style: TextStyle(
                fontSize: 8.sp,
                color: tdBlue,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 200.w,
                height: 45.h,
                decoration: BoxDecoration(
                    border: Border.all(color: tdBlack),
                    borderRadius: BorderRadius.circular(15).w
                ),
                child: Center(
                  child: Text('ADI20',style: TextStyle(fontSize: 27.sp,fontWeight: FontWeight.bold,color: tdBlack),),
                ),
              ),
              const SizedBox(),
              Container(
                width: 130.w,
                height: 45.h,
                decoration: BoxDecoration(
                    border: Border.all(color: tdBlack),
                    borderRadius: BorderRadius.circular(15).w,
                    color: tdBlack
                ),
                child: Center(
                  child: Text('COPY',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: tdWhite),),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          GestureDetector(
            onTap: (){
              GoRouter.of(context).go('/home');
            },
            child: Container(
              width: double.infinity,
              height: 45.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15).w,
                  border: Border.all(color: tdBlack)
              ),
              child: Center(
                child: Text('GO TO THE STORE',style: TextStyle(fontWeight: FontWeight.bold,color: tdBlack,fontSize: 12.sp),),
              ),
            ),
          ),
          SizedBox(height: 10.h,),
          Padding(
            padding: const EdgeInsets.all(8.0).w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shop your favorite Adidas wearables in Kuwait and get a guaranteed, huge discount! Just use the Adidas coupon code and get a flat 20% discount on the entire stock!',
                  style: TextStyle(fontSize: 12.sp,color: tdBlack,fontWeight: FontWeight.bold),),
                SizedBox(height: 10.h,),
                Text('Adidas Discount Code:',style: TextStyle(fontSize: 12.sp,color: tdBlack,fontWeight: FontWeight.bold),),
                SizedBox(height: 10.h,),
                const CouponsTable(),
                SizedBox(height: 10.h,),
                Text('Expires in 1 month',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.sp,color: tdBlack),),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

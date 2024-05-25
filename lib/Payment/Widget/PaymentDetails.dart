import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../Color&Icons/color.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20).w,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 70.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20).w,
                color: tdWhiteNav
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10,right: 15,left: 15,bottom: 5).w,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order ID',style: TextStyle(fontWeight: FontWeight.bold,color: tdBlack,fontSize: 12.sp),),
                      Text('Cart Amount',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: tdBlack),)
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('557606',style: TextStyle(fontWeight: FontWeight.bold,color: tdBlack,fontSize: 19.sp),),
                      Text('3.550 KWD',style: TextStyle(fontSize: 19.sp,fontWeight: FontWeight.bold,color: tdBlack),)
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h,),
          Container(
            width: double.infinity,
            height: 40.h,
            decoration: BoxDecoration(
                border: Border.all(color: tdBlack),
                color: tdWhite,
                borderRadius: BorderRadius.circular(15).w
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20).w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('You Have A Promo Code',style: TextStyle(fontWeight: FontWeight.bold,color: tdBlack,fontSize: 12.sp),),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h,),
          Container(
            width: double.infinity,
            height: 80.h,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15).w
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20,right: 15,left: 15,bottom: 5).w,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Discount',style: TextStyle(fontWeight: FontWeight.bold,color: tdBlack,fontSize: 12.sp),),
                      Text('Final Amount',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: tdBlack),)
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('0.000 KWD',style: TextStyle(fontWeight: FontWeight.bold,color: tdBlack,fontSize: 21.sp),),
                      Text('3.550 KWD',style: TextStyle(fontSize: 19.sp,fontWeight: FontWeight.bold,color: tdBlack),)
                    ],
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: 70.h),
          GestureDetector(
            onTap: (){
              context.push(context.namedLocation('ThanksPayment'));
            },
            child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                  color: tdBlack,
                  borderRadius: BorderRadius.circular(15).w
              ),
              child: Center(
                child: SizedBox(
                  width: 50.w,
                  height: 50.h,
                  child: Image.asset('assets/img/applepayment.png',fit: BoxFit.contain,),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: (){
              context.push(context.namedLocation('ThanksPayment'));
            },
            child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: tdWhite,
                borderRadius: BorderRadius.circular(15).w,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70.w,
                    height: 50.h,
                    child: Image.asset('assets/img/knet.png',fit: BoxFit.cover,),
                  ),
                  Text('K-Net',style: TextStyle(fontWeight: FontWeight.bold,color: tdBlack,fontSize: 15.sp),)
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: (){
              context.push(context.namedLocation('ThanksPayment'));
            },
            child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: tdWhite,
                borderRadius: BorderRadius.circular(15).w,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: Image.asset('assets/img/master.png',fit: BoxFit.contain,),
                ),
              ),
            ),
          ),
          SizedBox(height: 50.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('*By proceeding, you agree to our',style: TextStyle(fontSize: 8.sp,color: tdBlack,fontWeight: FontWeight.w500),
              ),
              Text(' TERMS & CONDITIONS',style: TextStyle(fontSize: 9.sp,color: tdBlue,fontWeight: FontWeight.bold),)
            ],
          )
        ],
      ),
    );
  }
}

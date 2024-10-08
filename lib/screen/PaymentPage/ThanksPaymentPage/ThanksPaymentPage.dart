import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/core/Color&Icons/color.dart';

class ThanksPayment extends StatefulWidget {
  const ThanksPayment({super.key});

  @override
  State<ThanksPayment> createState() => _ThanksPaymentState();
}

class _ThanksPaymentState extends State<ThanksPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20).w,
                    child: GestureDetector(
                      onTap: () {
                        GoRouter.of(context).go("/home");
                      },
                      child: SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: Image.asset('assets/img/pop3.png', fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  SizedBox(height: 100.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Thanks!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: tdWhite,
                          fontSize: 32.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 100.h),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: tdWhite,
                        borderRadius: BorderRadius.only(
                          topRight: const Radius.circular(70).w,
                          topLeft: const Radius.circular(70).w
                        )
                      ),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 120.w,
                            height: 120.h,
                            decoration: const BoxDecoration(
                              color: tdBlack,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(Icons.check, color: tdWhite,size: 80.w,),
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Text('Thanks for your purchasing',style: TextStyle(fontSize: 18.sp,color: tdBlack,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                          SizedBox(height: 10.h,),
                          Text('Your order will be delivered',style: TextStyle(fontSize: 10.sp,color: tdBlack),textAlign: TextAlign.center,),
                          Text('in 40 - 50 minutes',style: TextStyle(fontSize: 10.sp,color: tdBlack),textAlign: TextAlign.center,),
                          SizedBox(height: 20.h,),
                          GestureDetector(
                            onTap: (){
                              GoRouter.of(context).go("/home");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50).w,
                                border: Border.all(color: tdBlack)
                              ),
                              width: 210.w,
                              height: 40.h,
                              child: Center(
                                child: Text('Continue shopping',style: TextStyle(fontSize: 10.sp,color: tdBlack,fontWeight: FontWeight.bold),),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

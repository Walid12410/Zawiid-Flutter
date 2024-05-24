import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../Color&Icons/color.dart';
import '../../WatchDown/WatchCount.dart';

class DetailsUpComing extends StatelessWidget {
  const DetailsUpComing({
    super.key,
    required this.endTime,
  });

  final DateTime endTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 210.h,
            child: Image.asset(
              'assets/img/iphone.png',
              fit: BoxFit.contain,
            ),
          ),
           Text(
            'iPhone 14 ProMax / 256GB Black Color',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                color: tdBlack),
             textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('30th April. 10.00PM',style: TextStyle(fontSize: 8.sp,color: tdGrey),),
              Text(' Today',style: TextStyle(fontSize: 8.sp,color: tdGreen),)
            ],
          ),
          Text('Starting Price: 50KD',style: TextStyle(fontSize: 8.sp,color: tdGrey),),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: (){
              GoRouter.of(context).goNamed('BidPage');
            },
            child: Container(
              width: 180.w,
              height: 20.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20).w,
                  border: Border.all(color: tdBlack)
              ),
              child:  Center(
                child: Text('Zawiiidddd',style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.bold,color: tdBlack),),
              ),
            ),
          ),
          SizedBox(height: 5.h,),
          CountdownTimerScreen(endTime: endTime),
        ],
      ),
    );
  }
}

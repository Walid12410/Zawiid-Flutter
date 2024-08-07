import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Color&Icons/color.dart';


class ServiceCallUs extends StatelessWidget {
  const ServiceCallUs({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5).w,
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: tdWhite,
          borderRadius: BorderRadius.circular(15).w,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(0, 0),
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(3).w,
              child: SizedBox(
                height: 35.h,
                width: 35.w,
                child: Image.asset('assets/img/CustomerService/Group.png',fit: BoxFit.fill,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0).w,
              child: GestureDetector(
                onTap: (){
                  //calluse
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: tdWhiteNav,
                      borderRadius: BorderRadius.circular(20).w
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5).w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: 5.w,),
                        Text('Call Us',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.sp,color: tdBlack),),
                        SizedBox(width: 20.w,),
                        Text('+965 6037 8430',style: TextStyle(color: tdBlue,fontSize:  17.sp,fontWeight: FontWeight.bold),),
                        SizedBox(width: 5.w,),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

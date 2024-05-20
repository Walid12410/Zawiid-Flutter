import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Color&Icons/color.dart';

class SearchHistoryCard extends StatelessWidget {
  const SearchHistoryCard({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left:5, right: 5 ,bottom: 5).w,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
            color: tdWhite
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 25.w,
              height: 35.h,
              child: Image.asset('assets/img/iphone.png',fit: BoxFit.fill,),
            ),
            Padding(
              padding:const  EdgeInsets.all(5).w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Iphone 16 ProMax ',style: TextStyle(
                      fontSize: 12.sp,color: tdGrey,fontWeight: FontWeight.bold),),
                  Text('110\$',style: TextStyle(color: tdGrey,fontSize: 12.sp),)

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

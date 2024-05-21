import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';

import '../../../Color&Icons/color.dart';


class CouponsCardDetails extends StatelessWidget {
  const CouponsCardDetails({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              border:
              Border.all(color: const Color(-16214415)),
              borderRadius: BorderRadius.circular(5).w),
          child: Padding(
            padding: const EdgeInsets.only(top: 5).w,
            child: Column(
              children: [
                Text('40 %',
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(-16214415))),
                Text(
                  'OFF',
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(-16214415)),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                Container(
                    width: 40.w,
                    color: const Color(-16214415),
                    child:Center(
                      child: Text(
                        'Deal',
                        style: TextStyle(
                            color: tdWhite,
                            fontSize: 10.sp),
                      ),
                    )),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 10.sp,
        ),
        SizedBox(
          width: 180.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AdiClub Member Offer: Up to 40% Off For Member Only',
                style: TextStyle(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.bold,
                    color: tdBlack),
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Container(
                    color:tdGold,
                    child: Padding(
                      padding:const EdgeInsets.only(
                          left: 5,
                          right: 5).w,
                      child: Text(
                        'ADICLUB MEMBER',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: tdWhite,
                            fontSize: 8.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    'Expires in 1 day',
                    style: TextStyle(
                        fontSize: 8.sp,
                        color: tdGrey),
                  )
                ],
              ),
              SizedBox(height: 5.h),
              ReadMoreText(
                'Adidas is a globally recognized sportswear brand renowned for its innovative designs, high-quality products, and impactful contributions to sports and fashion. Established in 1949 by Adolf "Adi" Dassler in Herzogenaurach, Germany, Adidas has grown into one of the largest and most influential athletic brands in the world. The companys iconic three-stripe logo is synonymous with performance, style, and authenticity.',
                trimMode: TrimMode.Length,
                trimLength: 62,
                style: TextStyle(fontSize: 8.sp,color: tdGrey),
                colorClickableText: tdBlue,
                trimCollapsedText: 'More',
                trimExpandedText: 'Less',
                moreStyle: TextStyle(fontSize:  8.sp,color: tdBlue,fontWeight: FontWeight.bold),
                lessStyle: TextStyle(fontSize:  8.sp,color: tdBlue,fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  context.push(context.namedLocation('CouponsPromotion'));
                },
                child: Container(
                  width: double.infinity,
                  color: const Color(-9305855),
                  child: Padding(
                    padding:const  EdgeInsets.all(8).w,
                    child: Center(
                      child: Text('SHOW COUPON',style: TextStyle(fontWeight: FontWeight.bold,
                          color: tdWhite,fontSize: 8.sp),),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.wifi,size: 10.w,color: tdGrey,),
                      Text('23523 People Used',style: TextStyle(fontSize: 8.sp,
                          color: tdGrey),)
                    ],
                  ),
                  const Row(
                    children: [
                      SizedBox()
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.share,size: 10.w,color: tdGrey,),
                      Text('Share',style: TextStyle(color: tdBlue,fontSize: 8.sp),)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.email,size: 10.w,color: tdGrey,),
                      Text('Email',style: TextStyle(color: tdBlue,fontSize: 8.sp),)
                    ],
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

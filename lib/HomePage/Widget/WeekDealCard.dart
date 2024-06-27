import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../Color&Icons/color.dart';
import '../CountTime/CountTimerFeatured.dart';


class WeekDealCard extends StatelessWidget {
  const WeekDealCard({super.key, required this.price, required this.image,required this.startDate,required this.endDate});

  final DateTime startDate;
  final DateTime endDate;
  final String image;
  final String price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Center(
            child: SizedBox(
              width: 250.w,
              height: 180.h,
              child: CachedNetworkImage(
                imageUrl: image,
                placeholder: (context, url) =>
                    Image.asset('assets/log/LOGO-icon---Black.png'),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/log/LOGO-icon---Black.png'),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$price \$',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                            color: tdBlack),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      SizedBox(
                        width: 25.w,
                        height: 30.h,
                        child: SvgPicture.asset(
                          'assets/svg/buy.svg',
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    width: 140.w,
                    height: 0.2.h,
                    color: tdGrey,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'SKU: FT00962',
                    style: TextStyle(fontSize: 10.sp, color: tdGrey),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 5.h,),
                  Text(
                    'Hurry Up! Offer ends in:',
                    style: TextStyle(fontSize: 12.sp, color: tdGrey),
                  ),
                  SizedBox(height: 5.h),
                  CountTimerFeatured(startTime: startDate, endTime: endDate)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

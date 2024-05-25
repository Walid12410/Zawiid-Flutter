import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Color&Icons/color.dart';
import 'TimeWeekDeal.dart';



class WeekDealCard extends StatelessWidget {
  const WeekDealCard({super.key, required this.price, required this.image});

  final String image;
  final double price;

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
              height: 200.h,
              child: Image.asset(
                image,
                fit: BoxFit.contain,
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
                        '$price KD',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                            color: tdBlack),
                      ),
                      SizedBox(
                        width: 20.w,
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
                    width: 145.w,
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
                  Text(
                    'Hurry Up! Offer ends in:',
                    style: TextStyle(fontSize: 12.sp, color: tdGrey),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const TimerWeekDeal(
                        name: 'HOURS',
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      const TimerWeekDeal(
                        name: 'MINS',
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      const TimerWeekDeal(
                        name: 'Secs',
                      ),
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

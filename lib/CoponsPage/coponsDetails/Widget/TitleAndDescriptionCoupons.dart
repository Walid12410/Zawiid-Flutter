import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Color&Icons/color.dart';

class TitleAndDescription extends StatelessWidget {
  const TitleAndDescription({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

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
            height: 5.h,
          ),
          Text(
            'Adidas is the one-stop platform to purchase high-intensity sportswear and accessories in Kuwait. From its apparel to footwear, every new line is tested on the field so fitness enthusiasts and athletes can get the best products to break their PR and enhance their performance. Besides, you can grab the Adidas Promo Code from our website to avail yourself of great saving opportunities on all your Adidas shopping. Adidas believes in the power of sports, the significant impact they have on our lives and how they change us for the better. Its sports collection will reignite the passion of sports and fitness in you whether you love running, yoga, hiking, skateboarding or something else entirely. Furthermore, you needn’t worry about shopping for massive products from this sports giant with the Adidas Coupon Code. Adidas is loved by the Kuwaitis on the tracks, in the gym or another place because of its exclusively-made sportswear. You will find high tech sports apparel and footwear designed for athletes from football, training to golf and everything in between. Additionally, pay no attention to the retail value because by redeeming the Adidas Kuwait Promo Code, you will have knocked prices off by a big margin.',
            style: TextStyle(fontSize: 8.sp, color: tdBlack),
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';

class TabCard extends StatelessWidget {
  const TabCard({
    super.key,
    required this.productNo,
    required this.productName,
    required this.productDesc,
    required this.productImage,
    required this.productPrice,
    required this.markNo,
    required this.colorNo
  });

  final int productNo;
  final String productName;
  final String productDesc;
  final String productImage;
  final String productPrice;
  final int markNo;
  final int colorNo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        GoRouter.of(context).goNamed('itemDetails',pathParameters: {
          'itemNo': productNo.toString(),
          'colorNo': colorNo.toString(),
          'markNo' : markNo.toString()
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(5).w,
        child: Container(
          width: 165.w,
          decoration: BoxDecoration(
            color: tdWhite,
            borderRadius: BorderRadius.circular(5).w,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0).w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  '$productName $productDesc',
                  style: TextStyle(
                      fontSize: 8.sp, color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: SizedBox(
                    width: 100.w,
                    height: 130.h,
                    child: CachedNetworkImage(
                      imageUrl: productImage,
                      placeholder: (context, url) =>
                          Image.asset('assets/log/LOGO-icon---Black.png'),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/log/LOGO-icon---Black.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$productPrice \$',
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 2.w,),
                    SvgPicture.asset(
                      'assets/svg/buy.svg',
                      width: 27.w,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                const Divider(),
                Text(
                  'SKU: FT00962',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

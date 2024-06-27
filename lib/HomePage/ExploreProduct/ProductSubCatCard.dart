import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../Color&Icons/color.dart';


class ProductSubCategoriesHomePageCard extends StatelessWidget {
  const ProductSubCategoriesHomePageCard(
      {super.key,
        required this.title,
        required this.desc,
        required this.mainPrice,
        required this.salePrice,
        required this.image});
  final String title;
  final String desc;
  final String mainPrice;
  final String salePrice;
  final String image;


  @override
  Widget build(BuildContext context) {
    return Padding(
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
                '$title $desc',
                style: TextStyle(fontSize: 8.sp, color: Colors.black),
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
                    imageUrl: image,
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
                    '$mainPrice \$',
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
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
    );
  }
}

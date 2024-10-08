import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/core/Color&Icons/color.dart';

class CouponCard extends StatelessWidget {
  const CouponCard({
    super.key,
    required this.couponsId,
    required this.couponsImage,
    required this.markNo,
    required this.issueDate,
    required this.expiryDate,
  });

  final String couponsImage;
  final int couponsId;
  final DateTime issueDate;
  final DateTime expiryDate;
  final int markNo;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).w,
      child: GestureDetector(
        onTap: (){
          GoRouter.of(context).goNamed('CouponsDetails',pathParameters: {
            'markId' : markNo.toString(),
            'couponsId' : couponsId.toString(),
          });
        },
        child: Container(
          width: double.infinity,
          height: 120.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: tdWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(0, 0),
                blurRadius: 5,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: 130.w,
                height: 130.h,
                child:  CachedNetworkImage(
                  imageUrl: couponsImage,
                  placeholder: (context, url) =>
                      Image.asset('assets/log/LOGO-icon---Black.png'),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/log/LOGO-icon---Black.png'),
                  fit: BoxFit.contain,
                ),),
          ),
        ),
      ),
    );
  }
}

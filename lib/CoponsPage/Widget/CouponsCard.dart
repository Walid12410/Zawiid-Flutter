import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';

class CouponCard extends StatelessWidget {
  const CouponCard({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          context.push(context.namedLocation('CouponsDetails'));
        },
        child: Container(
          width: double.infinity,
          height: 150.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: tdWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(4.0, 4.0),
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: 131.w,
                height: 130.h,
                child: Image.asset('assets/img/adidas.png', fit: BoxFit.contain)),
          ),
        ),
      ),
    );
  }
}

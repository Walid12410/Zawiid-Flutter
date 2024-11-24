import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Widget/Header.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/provider/Coupons_Provider.dart';
import 'Details/CouponsPromotionDetails.dart';
import 'Details/LoadingContainerCouponsPromotion.dart';


class CouponsPromotion extends StatefulWidget {
  const CouponsPromotion({super.key,required this.getCouponsID});

  final int getCouponsID;

  @override
  State<CouponsPromotion> createState() => _CouponsPromotionState();
}

class _CouponsPromotionState extends State<CouponsPromotion> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      CouponsProvider couponsProvider = Provider.of<CouponsProvider>(context, listen: false);
      couponsProvider.getOneCoupon(widget.getCouponsID);
    });
  }

  @override
  Widget build(BuildContext context) {
    CouponsProvider couponsProvider = Provider.of<CouponsProvider>(context, listen: true);
    var getCoupons = couponsProvider.oneCoupon;


    if(getCoupons.isEmpty || getCoupons[0].couponNo != widget.getCouponsID){
      return const LoadingContainerCouponsPromotion();
    }

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PageHeadView(title: S.of(context).coupons , onPressed: (){
              context.pop();
            }),
            SizedBox(height: 2.h,),
            const CouponsPromotionDetails()
          ],
        ),
      )),
    );
  }
}





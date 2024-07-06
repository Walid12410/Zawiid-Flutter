import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Color&Icons/color.dart';
import '../../provider/Coupons_Provider.dart';
import 'Widget/CouponsPromotionDetails.dart';
import 'Widget/CouponsPromotionHead.dart';


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
      print('asdasdsd');
      couponsProvider.getCouponsById(widget.getCouponsID);
    });
  }

  @override
  Widget build(BuildContext context) {
    CouponsProvider couponsProvider = Provider.of<CouponsProvider>(context, listen: true);
    var getCoupons = couponsProvider.getCouponsByID;
    print(getCoupons);

    if(getCoupons.isEmpty || getCoupons[0].getCouponNo != widget.getCouponsID){
      return const Center(child: CircularProgressIndicator(color: tdBlack,),);
    }

    print(getCoupons);

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CouponsPromotionHead(),
            SizedBox(height: 2.h,),
            const CouponsPromotionDetails()
          ],
        ),
      )),
    );
  }
}




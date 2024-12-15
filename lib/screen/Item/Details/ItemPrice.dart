import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/provider/Offer_Provider.dart';

class ItemPrice extends StatelessWidget {
  const ItemPrice({
    super.key,
    required this.price,
    required this.discountedPrice
  });

  final double price;
  final double discountedPrice;

  @override
  Widget build(BuildContext context) {
    OfferProvider offerProvider = Provider.of<OfferProvider>(context, listen: true);
    var offerCheck = offerProvider.offerCheck;

    String offerPrice = (offerCheck.isNotEmpty && offerCheck[0].productPrice != null)
        ? offerCheck[0].productPrice.toString()
        : '0.0';

    if (offerPrice != '0.0') {
      return Row(
        children: [
          Text(
            '$price \$',
            style: TextStyle(
              fontSize: 14.sp,
              color: tdBlack,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.lineThrough,
              decorationThickness: 2.5,
              decorationColor: tdGrey,
            ),
          ),
          SizedBox(width: 15.w),
          Text(
            '$offerPrice \$',
            style: TextStyle(
              fontSize: 20.sp,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    } else if (discountedPrice > 0.0) {
      return Row(
        children: [
          Text(
            '$price \$',
            style: TextStyle(
              fontSize: 14.sp,
              color: tdBlack,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.lineThrough,
              decorationThickness: 2.5,
              decorationColor: tdGrey,
            ),
          ),
          SizedBox(width: 15.w),
          Text(
            '$discountedPrice \$',
            style: TextStyle(
              fontSize: 20.sp,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Text(
            '$price \$',
            style: TextStyle(
              fontSize: 20.sp,
              color: tdBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }
  }
}

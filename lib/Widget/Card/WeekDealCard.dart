import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Api/CartService.dart';
import 'package:zawiid/Widget/CountTime/CountTimerFeatured.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/core/config.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/model/offer/offer.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/Cart_Provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class WeekDealCard extends StatelessWidget {
  const WeekDealCard({
    Key? key,
    required this.offer
  }) : super(key: key);

  final Offer offer;

  void _toggleCart(BuildContext context) async {
    CartService service = CartService();
    final userID = Provider.of<AuthProvider>(context, listen: false).userId;
    if (userID == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text(
            S.of(context).loginError,
            style: TextStyle(fontSize: 10.sp, color: tdWhite),
          ),
          backgroundColor: tdBlack,
          duration:const Duration(seconds: 2),
        ),
      );
      return;
    }

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final isProductInCart = cartProvider.isProductInCart(offer.productNo);

    if (!isProductInCart) {
      cartProvider.addToCart(userID, offer.productNo, 1, offer.productPrice);
      service.addCartItem(
        userNo: userID,
        productNo: offer.productNo,
        productCartQty: 1,
        productCartPrice: double.parse(offer.productPrice),
      );
    } else {
      cartProvider.removeFromCart(offer.productNo);
      service.deleteCartItem(
        userNo: userID,
        productNo: offer.productNo,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final isProductInCart = cartProvider.isProductInCart(offer.productNo);

    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context).goNamed('itemDetails', pathParameters: {
                  'itemNo': offer.productNo.toString(),
                  'colorNo': offer.colorNo.toString(),
                  'markNo': offer.markNo.toString(),
                });
              },
              child: SizedBox(
                width: 250.w,
                height: 180.h,
                child: CachedNetworkImage(
                  imageUrl: '${ApiEndpoints.localBaseUrl}/${offer.productImage}',
                  placeholder: (context, url) =>
                      Image.asset('assets/log/LOGO-icon---Black.png'),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/log/LOGO-icon---Black.png'),
                      fit: BoxFit.contain,
                ),
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
                        '${offer.productPrice} \$',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                            color: tdBlack),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      GestureDetector(
                        onTap: () => _toggleCart(context),
                        child: isProductInCart
                            ? Icon(
                          Icons.remove_circle,
                          size: 27.w,
                          color: tdBlack,
                        )
                            : SvgPicture.asset(
                          'assets/svg/buy.svg',
                          width: 27.w,
                          fit: BoxFit.fill,
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
                    '${S.of(context).productCode}: FT00962',
                    style: TextStyle(fontSize: 10.sp, color: tdGrey),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    S.of(context).hurryUpOffer,
                    style: TextStyle(fontSize: 12.sp, color: tdGrey),
                  ),
                  SizedBox(height: 5.h),
                  CountTimerFeatured(
                    startTime: offer.startDate,
                    endTime: offer.endDate,
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


bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
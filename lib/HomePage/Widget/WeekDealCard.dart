import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../ApiService/CartService/AddCartApi.dart';
import '../../ApiService/CartService/DeleteFromCartApi.dart';
import '../../Color&Icons/color.dart';
import '../../provider/Auth_Provider.dart';
import '../../provider/Cart_Provider.dart';
import '../CountTime/CountTimerFeatured.dart';
import 'package:provider/provider.dart';

class WeekDealCard extends StatelessWidget {
  const WeekDealCard({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.image,
    required this.productNo,
    required this.colorNo,
    required this.markNo,
    required this.productOfferPrice,
  }) : super(key: key);

  final DateTime startDate;
  final DateTime endDate;
  final String image;
  final int productNo;
  final int colorNo;
  final int markNo;
  final String productOfferPrice;

  void _toggleCart(BuildContext context) async {
    final userID = Provider.of<AuthProvider>(context, listen: false).userId;
    if (userID == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text(
            'Login or SignUp please.',
            style: TextStyle(fontSize: 10.sp, color: tdWhite),
          ),
          backgroundColor: tdBlack,
          duration:const Duration(seconds: 2),
        ),
      );
      return;
    }

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final isProductInCart = cartProvider.isProductInCart(productNo);

    if (!isProductInCart) {
      cartProvider.addToCart(userID, productNo, 1, productOfferPrice);
      addCartItem(
        userNo: userID,
        productNo: productNo,
        productCartQty: 1,
        productCartPrice: double.parse(productOfferPrice),
      );
    } else {
      cartProvider.removeFromCart(productNo);
      deleteCartItem(
        userNo: userID,
        productNo: productNo,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final isProductInCart = cartProvider.isProductInCart(productNo);

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
                  'itemNo': productNo.toString(),
                  'colorNo': colorNo.toString(),
                  'markNo': markNo.toString(),
                });
              },
              child: SizedBox(
                width: 250.w,
                height: 180.h,
                child: CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (context, url) =>
                      Image.asset('assets/log/LOGO-icon---Black.png'),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/log/LOGO-icon---Black.png'),
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
                        '$productOfferPrice KD',
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
                    'SKU: FT00962',
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
                    'Hurry Up! Offer ends in:',
                    style: TextStyle(fontSize: 12.sp, color: tdGrey),
                  ),
                  SizedBox(height: 5.h),
                  CountTimerFeatured(
                    startTime: startDate,
                    endTime: endDate,
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../ApiService/CartService/AddCart.dart';
import '../../ApiService/CartService/CheckProductApi.dart';
import '../../ApiService/CartService/DeleteFromCartApi.dart';
import '../../Color&Icons/color.dart';
import '../../provider/Auth_Provider.dart';
import '../../provider/Cart_Provider.dart';
import '../CountTime/CountTimerFeatured.dart';
import 'package:provider/provider.dart';

class WeekDealCard extends StatefulWidget {
  const WeekDealCard(
      {super.key,
      required this.price,
      required this.image,
      required this.startDate,
      required this.endDate,
      required this.productNo,
      required this.colorNo,
      required this.markNo,
      required this.salePrice});

  final DateTime startDate;
  final DateTime endDate;
  final String image;
  final String price;
  final int productNo;
  final int colorNo;
  final int markNo;
  final String salePrice;

  @override
  _WeekDealCardState createState() => _WeekDealCardState();
}

class _WeekDealCardState extends State<WeekDealCard> {
  Future<void> _toggleCart() async {
    final userID = Provider.of<AuthProvider>(context, listen: false).userId;
    if (userID == 0) {
      return;
    }

    try {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final isProductInCart = cartProvider.cartUser.any((cartItem) =>
          cartItem.productNo == widget.productNo && cartItem.userNo == userID);

      if (isProductInCart) {
        await deleteCartItem(
            userNo: userID, productNo: widget.productNo, context: context);
        _showSnackBar('Item removed from cart');
      } else {
        await addCartItem(
          userNo: userID,
          productNo: widget.productNo,
          productCartQty: 1,
          productCartPrice: double.parse(widget.salePrice) > 0.0
              ? double.parse(widget.salePrice)
              : double.parse(widget.price),
          context: context,
        );
        _showSnackBar('Item added to cart');
      }
      cartProvider.getAllCartOfUser(userID);
    } catch (e) {
      throw Exception(e);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: tdBlack,
        content: Text(
          message,
          style: TextStyle(
              fontSize: 10.sp, fontWeight: FontWeight.bold, color: tdWhite),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context).goNamed('itemDetails', pathParameters: {
                  'itemNo': widget.productNo.toString(),
                  'colorNo': widget.colorNo.toString(),
                  'markNo': widget.markNo.toString(),
                });
              },
              child: SizedBox(
                width: 250.w,
                height: 180.h,
                child: CachedNetworkImage(
                  imageUrl: widget.image,
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
                        '${widget.price} \$',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                            color: tdBlack),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      GestureDetector(
                        onTap: _toggleCart,
                        child: SizedBox(
                          width: 25.w,
                          height: 30.h,
                          child: SvgPicture.asset(
                            'assets/svg/buy.svg',
                            fit: BoxFit.contain,
                          ),
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
                      startTime: widget.startDate, endTime: widget.endDate)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';
import '../../ApiService/CartService/AddCart.dart';
import '../../ApiService/CartService/DeleteFromCartApi.dart';
import '../../provider/Auth_Provider.dart';
import 'package:provider/provider.dart';

import '../../provider/Cart_Provider.dart';

class TabCard extends StatefulWidget {
  const TabCard(
      {super.key,
      required this.productNo,
      required this.productName,
      required this.productDesc,
      required this.productImage,
      required this.productPrice,
      required this.markNo,
      required this.colorNo,
      required this.productSalePrice});

  final int productNo;
  final String productName;
  final String productDesc;
  final String productImage;
  final String productPrice;
  final int markNo;
  final int colorNo;
  final String productSalePrice;

  @override
  _TabCardState createState() => _TabCardState();
}

class _TabCardState extends State<TabCard> {
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
          productCartPrice: double.parse(widget.productSalePrice) > 0.0
              ? double.parse(widget.productSalePrice)
              : double.parse(widget.productPrice),
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
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).goNamed('itemDetails', pathParameters: {
          'itemNo': widget.productNo.toString(),
          'colorNo': widget.colorNo.toString(),
          'markNo': widget.markNo.toString(),
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
                  '${widget.productName} ${widget.productDesc}',
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
                      imageUrl: widget.productImage,
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
                      '${widget.productPrice} KD',
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    GestureDetector(
                      onTap: _toggleCart,
                      child: SvgPicture.asset(
                        'assets/svg/buy.svg',
                        width: 27.w,
                        fit: BoxFit.fill,
                      ),
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

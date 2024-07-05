import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../ApiService/CartService/AddCart.dart';
import '../../ApiService/CartService/CheckProductApi.dart';
import '../../ApiService/CartService/DeleteFromCartApi.dart';
import '../../Color&Icons/color.dart';
import '../../provider/Auth_Provider.dart';
import '../../provider/Cart_Provider.dart';
import '../../Classes/Cart/Cart.dart';
import '../../ApiEndPoint.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductSubCategoriesHomePageCard extends StatefulWidget {
  const ProductSubCategoriesHomePageCard({
    super.key,
    required this.title,
    required this.desc,
    required this.mainPrice,
    required this.salePrice,
    required this.image,
    required this.productNo,
    required this.markNo,
    required this.colorNo,
  });

  final String title;
  final String desc;
  final String mainPrice;
  final String salePrice;
  final String image;
  final int productNo;
  final int markNo;
  final int colorNo;

  @override
  _ProductSubCategoriesHomePageCardState createState() =>
      _ProductSubCategoriesHomePageCardState();
}

class _ProductSubCategoriesHomePageCardState
    extends State<ProductSubCategoriesHomePageCard> {
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
              : double.parse(widget.mainPrice),
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
    return Padding(
      padding: const EdgeInsets.all(5).w,
      child: GestureDetector(
        onTap: () {
          GoRouter.of(context).goNamed('itemDetails', pathParameters: {
            'itemNo': widget.productNo.toString(),
            'colorNo': widget.colorNo.toString(),
            'markNo': widget.markNo.toString(),
          });
        },
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
                  '${widget.title} ${widget.desc}',
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
                      imageUrl: widget.image,
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
                      '${widget.mainPrice} KD',
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

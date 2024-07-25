import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../ApiService/CartService/AddCartApi.dart';
import '../../ApiService/CartService/DeleteFromCartApi.dart';
import '../../Color&Icons/color.dart';
import '../../provider/Auth_Provider.dart';
import '../../provider/Cart_Provider.dart';

class ProductSubCategoriesHomePageCard extends StatelessWidget {
  const ProductSubCategoriesHomePageCard({
    Key? key,
    required this.title,
    required this.desc,
    required this.mainPrice,
    required this.salePrice,
    required this.image,
    required this.productNo,
    required this.markNo,
    required this.colorNo,
  }) : super(key: key);

  final String title;
  final String desc;
  final String mainPrice;
  final String salePrice;
  final String image;
  final int productNo;
  final int markNo;
  final int colorNo;

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

    double price = double.parse(salePrice) > 0.0
        ? double.parse(salePrice)
        : double.parse(mainPrice);

    if (!isProductInCart) {
      cartProvider.addToCart(userID, productNo, 1, price.toString());
      addCartItem(
        userNo: userID,
        productNo: productNo,
        productCartQty: 1,
        productCartPrice: price,
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

    return Padding(
      padding: EdgeInsets.all(5).w,
      child: GestureDetector(
        onTap: () {
          GoRouter.of(context).goNamed('itemDetails', pathParameters: {
            'itemNo': productNo.toString(),
            'colorNo': colorNo.toString(),
            'markNo': markNo.toString(),
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
            padding: EdgeInsets.all(5.0).w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  '$title $desc',
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
                      imageUrl: image,
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
                      '$mainPrice KD',
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 2.w,
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

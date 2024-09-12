import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/provider/Cart_Provider.dart';
import '../../ApiService/CartService/AddCartApi.dart';
import '../../ApiService/CartService/DeleteFromCartApi.dart';
import '../../Color&Icons/color.dart';
import '../../provider/Auth_Provider.dart';
import 'package:zawiid/generated/l10n.dart';

class CartItemView extends StatelessWidget {
  const CartItemView({
    Key? key,
    required this.title,
    required this.mainPrice,
    required this.salePrice,
    required this.image,
    required this.markNo,
    required this.colorNo,
    required this.productNo,
    required this.markName,
    required this.colorName,
  }) : super(key: key);

  final String title;
  final String mainPrice;
  final String salePrice;
  final String image;
  final int markNo;
  final int colorNo;
  final int productNo;
  final String markName;
  final String colorName;

  @override
  Widget build(BuildContext context) {
    final salePriceValue = double.tryParse(salePrice) ?? 0.0;
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final isProductInCart = cartProvider.isProductInCart(productNo);
    final auth = Provider.of<AuthProvider>(context, listen: false);

    double price =
        salePriceValue > 0.0 ? salePriceValue : double.parse(mainPrice);

    return GestureDetector(
      onTap: () {
        context.push(
          '/home/itemDetails/$productNo/$colorNo/$markNo',
        );
      },
      child: Container(
        width: 160.w,
        decoration: BoxDecoration(
          color: tdWhite,
          borderRadius: BorderRadius.circular(10).w,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.h),
            SizedBox(
              width: 120.w,
              height: 110.h,
              child: CachedNetworkImage(
                imageUrl: image,
                placeholder: (context, url) =>
                    Image.asset('assets/log/LOGO-icon---Black.png'),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/log/LOGO-icon---Black.png'),
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20).w,
              child: Text(
                markName,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: tdBlack,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15).w,
              child: Text(
                formatDesc('$title $colorName'),
                style: TextStyle(
                  fontSize: 8.sp,
                  color: tdBlack,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            SizedBox(height: 5.h),
            if (salePriceValue > 0.0) ...[
              Text(
                '$salePrice \$',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: Colors.red,
                ),
              ),
              Text(
                '$mainPrice \$',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: tdBlack,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.lineThrough,
                  decorationThickness: 2.5,
                  decorationColor: tdGrey,
                ),
              ),
            ] else ...[
              Text(
                '$mainPrice \$',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: tdBlack,
                ),
              ),
              Text(
                '',
                style: TextStyle(fontSize: 10.sp),
              ),
            ],
            SizedBox(height: 5.h),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10).w,
              child: GestureDetector(
                onTap: () {
                  if (auth.userId == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          S.of(context).loginError,
                          style: TextStyle(fontSize: 10.sp, color: tdWhite),
                        ),
                        backgroundColor: tdBlack,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    return;
                  } else if (!isProductInCart) {
                    cartProvider.addToCart(
                        auth.userId, productNo, 1, price.toString());
                    addCartItem(
                      userNo: auth.userId,
                      productNo: productNo,
                      productCartQty: 1,
                      productCartPrice: price,
                    );
                  } else if (isProductInCart) {
                    cartProvider.removeFromCart(productNo);
                    deleteCartItem(
                      userNo: auth.userId,
                      productNo: productNo,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          S.of(context).loginError,
                          style: TextStyle(fontSize: 10.sp, color: tdWhite),
                        ),
                        backgroundColor: tdBlack,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    return;
                  }
                },
                child: Container(
                  height: 25.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: tdBlack,
                    borderRadius: BorderRadius.circular(5).w,
                  ),
                  child: Center(
                    child: Text(
                      isProductInCart
                          ? S.of(context).removeFromCart
                          : S.of(context).addToCart,
                      style: TextStyle(fontSize: 8.sp, color: tdWhite),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }
}

String formatDesc(String desc) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: desc, style: TextStyle(fontSize: 8.sp)),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  );
  textPainter.layout(minWidth: 0, maxWidth: double.infinity);
  final bool isOneLine = textPainter.didExceedMaxLines == false;
  return isOneLine ? '$desc\n' : desc;
}

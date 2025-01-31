import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:zawiid/Api/CartService.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/core/config.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/model/Product/Products.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/Cart_Provider.dart';
import 'package:zawiid/provider/Offer_Provider.dart';

class TabCardProduct extends StatelessWidget {
  const TabCardProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

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
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final offerProvider = Provider.of<OfferProvider>(context, listen: false);

    final isProductInCart = cartProvider.isProductInCart(product.productNo);

    // Check if the product is in an active offer
    bool isInOffer =
        offerProvider.allOffer.any((o) => o.productNo == product.productNo);

    double price = isInOffer
        ? double.parse(offerProvider.allOffer
            .firstWhere((o) => o.productNo == product.productNo)
            .productPrice)
        : (double.tryParse(product.discountedPrice) != null &&
                double.parse(product.discountedPrice) > 0
            ? double.parse(
                product.discountedPrice) // Use discounted price if available
            : double.parse(product.price)); // Otherwise, use the normal price

    if (!isProductInCart) {
      cartProvider.addToCart(userID, product.productNo, 1, price.toString());
      await service.addCartItem(
        userNo: userID,
        productNo: product.productNo,
        productCartQty: 1,
        productCartPrice: price,
      );
    } else {
      cartProvider.removeFromCart(product.productNo);
      await service.deleteCartItem(
        userNo: userID,
        productNo: product.productNo,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final isProductInCart = cartProvider.isProductInCart(product.productNo);

    return GestureDetector(
      onTap: () {
        GoRouter.of(context).goNamed('itemDetails', pathParameters: {
          'itemNo': product.productNo.toString(),
          'colorNo': product.colorNo.toString(),
          'markNo': product.markNo.toString(),
        });
      },
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: Container(
          width: 165.w,
          decoration: BoxDecoration(
            color: tdWhite,
            borderRadius: BorderRadius.circular(5.w),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  '${product.productName} ${product.productDesc}',
                  style: TextStyle(fontSize: 8.sp, color: tdBlack),
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
                      imageUrl: '${ApiEndpoints.localBaseUrl}/${product.productImage}',
                      placeholder: (context, url) =>
                          Image.asset('assets/log/LOGO-icon---Black.png'),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/log/LOGO-icon---Black.png'),
                          fit: BoxFit.contain,
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
                      '${product.price} \$',
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
                  '${S.of(context).productCode}: FT00962',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp,
                      color: tdGrey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
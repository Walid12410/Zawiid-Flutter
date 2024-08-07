import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import '../../ApiService/CartService/AddCartApi.dart';
import '../../ApiService/CartService/DeleteFromCartApi.dart';
import '../../Color&Icons/color.dart';
import '../../provider/Cart_Provider.dart';

class ItemBottoms extends StatelessWidget {
  const ItemBottoms({
    Key? key,
    required this.productNo,
    required this.productPrice,
    required this.productSalePrice,
  }) : super(key: key);

  final int productNo;
  final String productPrice;
  final String productSalePrice;

  @override
  Widget build(BuildContext context) {
    final cartView = Provider.of<CartProvider>(context, listen: true);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final isProductInCart = cartView.isProductInCart(productNo);

    double price = double.parse(productSalePrice) > 0.0
        ? double.parse(productSalePrice)
        : double.parse(productPrice);

    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            if (auth.userId == 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Login or SignUp please.',
                    style: TextStyle(fontSize: 10.sp, color: tdWhite),
                  ),
                  backgroundColor: tdBlack,
                  duration: const Duration(seconds: 2),
                ),
              );
              return;
            } else if (!isProductInCart) {
              cartView.addToCart(auth.userId, productNo, 1, price.toString());
              await addCartItem(
                userNo: auth.userId,
                productNo: productNo,
                productCartQty: 1,
                productCartPrice: price,
              );
            } else if (isProductInCart) {
              cartView.removeFromCart(productNo);
              await deleteCartItem(
                userNo: auth.userId,
                productNo: productNo,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Login or SignUp please.',
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
            width: 220.w,
            height: 30.h,
            decoration: BoxDecoration(
              border: Border.all(color: tdBlack),
              borderRadius: BorderRadius.circular(20).w,
            ),
            child: Center(
              child: Text(
                isProductInCart ? 'Remove from cart' : 'Add to cart',
                style: TextStyle(
                  color: tdBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: () async {
            if (auth.userId == 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Login or SignUp please.',
                    style: TextStyle(fontSize: 10.sp, color: tdWhite),
                  ),
                  backgroundColor: tdBlack,
                  duration: const Duration(seconds: 2),
                ),
              );
              return;
            }
            if (!isProductInCart) {
              context.push(context.namedLocation('CartPage'));
              cartView.addToCart(auth.userId, productNo, 1, price.toString());
              await addCartItem(
                userNo: auth.userId,
                productNo: productNo,
                productCartQty: 1,
                productCartPrice: price,
              );
            }else{
              context.push(context.namedLocation('CartPage'));
            }
          },
          child: Container(
            width: 110.w,
            height: 30.h,
            decoration: BoxDecoration(
              border: Border.all(color: tdBlack),
              borderRadius: BorderRadius.circular(20).w,
            ),
            child: Center(
              child: Text(
                'Buy',
                style: TextStyle(
                  color: tdBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import '../../ApiService/CartService/AddCart.dart';
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
    var cartCheck = cartView.viewCartFound;
    final auth = Provider.of<AuthProvider>(context, listen: false);

    double price = double.parse(productSalePrice) > 0.0
        ? double.parse(productSalePrice)
        : double.parse(productPrice);

    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            if(auth.userId == 0 ){
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
            }else if (cartCheck.isEmpty) {
              await addCartItem(
                userNo: auth.userId,
                productNo: productNo,
                productCartQty: 1,
                productCartPrice: price,
                context: context,
              );
              await cartView.getIfCartIsAdded(auth.userId, productNo);
            } else {
              await deleteCartItem(
                userNo: auth.userId,
                productNo: productNo,
                context: context,
              );
              await cartView.getIfCartIsAdded(auth.userId, productNo);
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
                cartCheck.isEmpty ? 'Add to cart' : 'Remove from cart',
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
          onTap: () {
            // Buy action
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
        )
      ],
    );
  }
}

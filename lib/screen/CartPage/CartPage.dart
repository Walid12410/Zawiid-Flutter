import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Api/CartService.dart';
import 'package:zawiid/Widget/Header.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/Cart_Provider.dart';
import 'package:zawiid/provider/Delivery_Provider.dart';
import 'package:zawiid/screen/AccountInfoPage/Details/GuestView.dart';
import 'DeliveryOptions.dart';
import 'Details/CartContainer.dart';
import 'package:intl/intl.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      cartProvider.getAllCartOfUser(authProvider.userId);
      cartProvider.getAllCartDetailsOfUser(authProvider.userId);
    });
  }

  void _showClearCartDialog(BuildContext context, int userID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final cartProvider = Provider.of<CartProvider>(context, listen: false);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20).w,
          ),
          backgroundColor: tdWhite,
          surfaceTintColor: tdWhite,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).areYouSure,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: tdBlack,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                S.of(context).toClearCart,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: tdBlack,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      CartService service = CartService();
                      cartProvider.clearCartsDetails();
                      cartProvider.clearCart();
                      Navigator.of(context).pop();
                      service.deleteAllCartItemsByUserNo(userID);
                    },
                    child: Container(
                      width: 100.w,
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: tdWhite,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          S.of(context).yes,
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: tdBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 100.w,
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: tdBlack,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          S.of(context).no,
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: tdWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double price = 0.0;

    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final deliveryOptions =
        Provider.of<DeliveryProvider>(context, listen: true);
    var cartItem = cartProvider.cartDetailsUser;

    var deliveryPrice = deliveryOptions.oneDeliveryOptions.isNotEmpty
        ? deliveryOptions.oneDeliveryOptions.first
        : null;

    var allDeliveryOptions = deliveryOptions.allDeliveryOpt.isNotEmpty
        ? deliveryOptions.allDeliveryOpt.first
        : null;

    try {
      if (deliveryOptions.optionsSelected == 0) {
        if (allDeliveryOptions != null &&
            allDeliveryOptions.additionalCost.isNotEmpty &&
            double.tryParse(allDeliveryOptions.additionalCost) != null &&
            double.parse(allDeliveryOptions.additionalCost) > 0) {
          price = double.parse(allDeliveryOptions.additionalCost);
        } else {
          price = 0.0;
        }
      } else {
        if (deliveryPrice != null &&
            deliveryPrice.additionalCost.isNotEmpty &&
            double.tryParse(deliveryPrice.additionalCost) != null &&
            double.parse(deliveryPrice.additionalCost) > 0) {
          price = double.parse(deliveryPrice.additionalCost);
        } else {
          price = 0.0;
        }
      }
    } catch (e) {
      throw Exception(e);
    }

    return authProvider.userId != 0
        ? Scaffold(
            backgroundColor: tdWhite,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    PageHeadView(
                      title: S.of(context).cart,
                      onPressed: () {
                        context.pop();
                      },
                    ),
                    SizedBox(height: 5.h),
                    Padding(
                      padding: isArabic()
                          ? const EdgeInsets.only(left: 8).w
                          : const EdgeInsets.only(right: 8).w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (cartItem.isNotEmpty) {
                                _showClearCartDialog(
                                    context, authProvider.userId);
                              } else {
                                null;
                              }
                            },
                            child: Text(
                              S.of(context).clearCart,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: tdBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    cartItem.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cartItem.length,
                            itemBuilder: (context, index) {
                              var cart = cartItem[index];
                              return CartContainer(
                                productNo: cart.productNo,
                                productCartPrice: cart.productCartPrice,
                                cartQuantity: cart.productCartQty,
                                productName: cart.productName,
                                productDesc: cart.productDesc,
                                productImage: cart.productImage,
                              );
                            },
                          )
                        : Column(
                            children: [
                              SizedBox(height: 200.h),
                              Center(
                                child: Text(
                                  S.of(context).cartEmpty,
                                  style:
                                      TextStyle(fontSize: 12.sp, color: tdGrey),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              surfaceTintColor: tdWhite,
              color: tdWhite,
              height: 135.h,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    color: tdGreyHome,
                    borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50))
                        .w),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0).w,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).subtotal,
                                style:
                                    TextStyle(color: tdBlack, fontSize: 12.sp),
                              ),
                              Text(
                                '${cartProvider.totalPrice.toStringAsFixed(2)} \$',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: tdBlack),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).delivery,
                                style:
                                    TextStyle(color: tdBlack, fontSize: 12.sp),
                              ),
                              Text(
                                '$price \$',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: tdBlack),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).totalEstimation,
                                style:
                                    TextStyle(color: tdBlack, fontSize: 12.sp),
                              ),
                              Text(
                                '${double.parse(cartProvider.totalPrice.toStringAsFixed(2)) + price} \$',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: tdBlack),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50).w,
                            border: Border.all(color: tdBlack),
                            color: tdBlack,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (cartItem.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          S.of(context).cartEmpty,
                                          style: TextStyle(
                                              fontSize: 10.sp, color: tdWhite),
                                        ),
                                        backgroundColor: tdBlack,
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                    return;
                                  }
                                  context.push(
                                      context.namedLocation('shippingAddress'));
                                },
                                child: Container(
                                  width: 220.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50).w,
                                    border: Border.all(color: tdBlack),
                                    color: tdWhite,
                                  ),
                                  child: Center(
                                    child: Text(
                                      S.of(context).selectAddress,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: tdBlack,
                                          fontSize: 12.sp),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DeliveryOptionDialog();
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: isArabic()
                                        ? BorderRadius.only(
                                            bottomLeft:
                                                const Radius.circular(50).w,
                                            topLeft:
                                                const Radius.circular(50).w)
                                        : BorderRadius.only(
                                            bottomRight:
                                                const Radius.circular(50).w,
                                            topRight:
                                                const Radius.circular(50).w),
                                    border: Border.all(color: tdBlack),
                                    color: tdBlack,
                                  ),
                                  child: Padding(
                                    padding: isArabic()? const EdgeInsets.only(right: 10)
                                        .w:
                                        const EdgeInsets.only(left: 10)
                                            .w,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            width: 25.w,
                                            height: 25.w,
                                            child: SvgPicture.asset(
                                              'assets/svg/delivery.svg',
                                              fit: BoxFit.fill,
                                              color: tdWhite,
                                            )),
                                        Center(
                                          child: Text(
                                            S.of(context).deliveryOptions,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: tdWhite,
                                                fontSize: 8.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: tdWhite,
            body: SafeArea(
              child: Column(
                children: [
                  PageHeadView(
                    title: S.of(context).cart,
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  SizedBox(
                    height: 180.h,
                  ),
                  const GuestViewProfile()
                ],
              ),
            ),
          );
  }
}

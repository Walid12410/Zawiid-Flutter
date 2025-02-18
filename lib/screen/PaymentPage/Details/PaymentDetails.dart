import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Api/CartService.dart';
import 'package:zawiid/Api/CouponsService.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/provider/Address_Provider.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/Cart_Provider.dart';
import 'package:zawiid/provider/Delivery_Provider.dart';
import 'package:intl/intl.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({Key? key}) : super(key: key);

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  late TextEditingController promoCodeController;
  late CartProvider cartProvider;
  late AddressProvider addressProvider;
  late AuthProvider authProvider;
  late DeliveryProvider deliveryProvider;
  double orderTotal = 0.0;
  double finalPrice = 0.0;
  double savePrice = 0.0;
  double savingPercent = 0.0;
  bool _isProcessingOrder = false;
  String validForCoupons = "";
  String promoCodeShow = 'You Have A Promo Code';

  @override
  void initState() {
    super.initState();
    promoCodeController = TextEditingController();
  }

  @override
  void dispose() {
    promoCodeController.dispose();
    super.dispose();
  }

  Future<void> _promoError(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            S.of(context).promoCode,
            style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: TextStyle(fontSize: 10.sp, color: Colors.black),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 75.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5).w,
                  child: Center(
                    child: Text(
                      S.of(context).ok,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 10.sp),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void _showPromoCodeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        authProvider = Provider.of<AuthProvider>(context, listen: false);
        return AlertDialog(
          backgroundColor: tdWhite,
          surfaceTintColor: tdWhite,
          title: Text(
            S.of(context).enterPromoCode,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 12.sp, color: tdBlack),
          ),
          content: TextField(
            controller: promoCodeController,
            cursorColor: tdBlack,
            decoration: InputDecoration(
              hintText: S.of(context).promoCode,
              hintStyle: TextStyle(color: tdBlack, fontSize: 10.sp),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: tdBlack),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: tdBlack),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: tdBlack),
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _applyPromoCode(
                        promoCodeController.text, authProvider.userId);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 100.w,
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        S.of(context).apply,
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
                        S.of(context).cancel,
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _applyPromoCode(String promoCode, userId) async {
    CouponsService service = CouponsService();

    if (promoCode.isNotEmpty) {
      try {
        Map<String, dynamic> promoResult =
            await service.validatePromoCode(userId, promoCode, orderTotal);

        if (promoResult['valid']) {
          double savingsPercent = double.parse(promoResult['savings']);
          double savingsAmount = (savingsPercent / 100) * orderTotal;
          String validFor = promoResult['validFor'];
          String expiryDateStr = promoResult['ExpiryDate'];

          // Parse the expiry date
          DateTime expiryDate = DateTime.parse(expiryDateStr);
          DateTime currentDate = DateTime.now();

          if (currentDate.isBefore(expiryDate)) {
            setState(() {
              validForCoupons = validFor;
              savingPercent = savingsPercent;
              promoCodeShow = promoCodeController.text;
              finalPrice = orderTotal - savingsAmount;
              savePrice = savingsAmount;
            });
            _showErrorSnackBar('Promo code applied successfully');
          } else {
            _promoError('Promo code has expired.');
          }
        } else {
          String errorMessage = promoResult['message'] ?? 'Invalid promo code.';
          _promoError(errorMessage);
        }
      } catch (e) {
        _promoError('An error occurred while applying the promo code.');
      }
    } else {
      _promoError('Promo code cannot be empty.');
    }
  }

  Future<void> _createOrder(
      userId, orderTotalPrice, addressNo, deliveryOption) async {
    CouponsService couponService = CouponsService();
    CartService cartService = CartService();

    if (_isProcessingOrder) return;

    String promoCode = promoCodeController.text;
    final orderStartDate = DateTime.now();

    setState(() {
      _isProcessingOrder = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            color: tdBlack,
          ),
        );
      },
    );

    try {
      bool orderCreated = await cartProvider.createOrder(
          userId,
          orderStartDate.toString(),
          orderStartDate.toString(),
          addressNo,
          promoCode,
          savingPercent,
          validForCoupons,
          deliveryOption);

      if (orderCreated) {
        if (promoCode.isNotEmpty) {
          await couponService.updateCouponUsed(userId, promoCode);
        }
        await cartService.deleteAllCartItemsByUserNo(userId);
        cartProvider.clearCart();
        setState(() {
          context.push(context.namedLocation('ThanksPayment'));
        });
      } else {
        _showErrorSnackBar('Something went wrong');
      }
    } catch (e) {
      _showErrorSnackBar('An error occurred');
    } finally {
      setState(() {
        Navigator.of(context).pop();
        _isProcessingOrder = false;
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 10.sp, color: tdWhite),
        ),
        backgroundColor: tdBlack,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context, listen: true);
    addressProvider = Provider.of<AddressProvider>(context, listen: true);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    deliveryProvider = Provider.of<DeliveryProvider>(context, listen: true);
    orderTotal = cartProvider.totalPrice;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: tdWhiteNav,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).orderID,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 12.sp),
                      ),
                      Text(
                        S.of(context).cartAmount,
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '557606',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 17.sp),
                      ),
                      Text(
                        '${cartProvider.totalPrice.toStringAsFixed(2)} \$',
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: () {
              _showPromoCodeDialog();
            },
            child: Container(
              width: double.infinity,
              height: 40.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15).w,
                  color: tdWhite,
                  border: Border.all(color: tdBlack)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15).w,
                    child: Text(
                      promoCodeShow,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: tdBlack,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey4,
              borderRadius: BorderRadius.circular(15).w,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).discount,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 12.sp),
                      ),
                      Text(
                        S.of(context).finalAmount,
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${savePrice.toStringAsFixed(2)} \$',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: tdBlack,
                            fontSize: 17.sp),
                      ),
                      Text(
                        '${finalPrice == 0.0 ? orderTotal.toStringAsFixed(2) : finalPrice.toStringAsFixed(2)} \$',
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                            color: tdBlack),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 70.h),
          GestureDetector(
            onTap: () {
              _createOrder(
                  authProvider.userId,
                  orderTotal,
                  addressProvider.defaultAddressNo,
                  deliveryProvider.optionsSelected);
            },
            child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: tdBlack,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: SizedBox(
                  width: 50.w,
                  height: 50.h,
                  child: Image.asset('assets/img/applepayment.png',
                      fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: () {
              _createOrder(
                  authProvider.userId,
                  orderTotal,
                  addressProvider.defaultAddressNo,
                  deliveryProvider.optionsSelected);
            },
            child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: tdWhite,
                borderRadius: BorderRadius.circular(15).w,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70.w,
                    height: 50.h,
                    child: Image.asset(
                      'assets/img/knet.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    'K-Net',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: tdBlack,
                        fontSize: 15.sp),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: () {
              _createOrder(
                  authProvider.userId,
                  orderTotal,
                  addressProvider.defaultAddressNo,
                  deliveryProvider.optionsSelected);
            },
            child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: tdWhite,
                borderRadius: BorderRadius.circular(15).w,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: Image.asset(
                    'assets/img/master.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 50.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                S.of(context).byProceeding,
                style: TextStyle(
                    fontSize: 8.sp,
                    color: tdBlack,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                ' ${S.of(context).termsOfService}',
                style: TextStyle(
                    fontSize: 9.sp, color: tdBlue, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}

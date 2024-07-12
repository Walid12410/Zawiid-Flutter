import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/ApiService/CouponsService/UpdateUsedCouponsApi.dart';
import 'package:zawiid/provider/Address_Provider.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/Cart_Provider.dart';
import '../../ApiService/CartService/DeleteAllCartByUserApi.dart';
import '../../Color&Icons/color.dart';

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
  double orderTotal = 0.0;
  double finalPrice = 0.0;
  double savePrice = 0.0;
  double savingPercent = 0.0;

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
            'Promo Code',
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
                      'OK',
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

  void _applyPromoCode(String promoCode, userId) async {
    if (promoCode.isNotEmpty) {
      Map<String, dynamic> promoResult =
      await cartProvider.validatePromoCode(userId, promoCode, orderTotal);
      if (promoResult['valid']) {
        double savingsPercent = double.parse(promoResult['savings']);
        double savingsAmount = (savingsPercent / 100) * orderTotal;
        setState(() {
          savingPercent = double.parse(promoResult['savings']);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Promo code applied successfully.',
              style: TextStyle(fontSize: 10.sp, color: tdWhite),
            ),
            backgroundColor: tdBlack,
            duration: const Duration(seconds: 2),
          ),
        );
        setState(() {
          finalPrice = orderTotal - savingsAmount;
          savePrice = savingsAmount;
        });
      } else {
        String errorMessage = promoResult['message'] ?? 'Invalid promo code.';
        _promoError(errorMessage);
      }
    } else {
      _promoError('Promo code cannot be empty.');
    }
  }

  Future<void> _createOrder(userId,orderTotalPrice,addressNo) async {
    String promoCode = promoCodeController.text;
    final orderStartDate = DateTime.now();
    bool orderCreated = await cartProvider.createOrder(
      userId,
      orderStartDate.toString(),
      orderStartDate.toString(),
      addressNo,
      promoCode,
      savingPercent,
    );
    if (orderCreated) {
      if (promoCode != "") {
        await updateCouponUsed(userId, promoCode);
      }
      await deleteAllCartItemsByUserNo(userId, context);
      context.push(context.namedLocation('ThanksPayment'));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Something went wrong',
            style: TextStyle(fontSize: 10.sp, color: tdWhite),
          ),
          backgroundColor: tdBlack,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context, listen: true);
    addressProvider = Provider.of<AddressProvider>(context, listen: true);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
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
                        'Order ID',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 12.sp),
                      ),
                      Text(
                        'Cart Amount',
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
                            fontSize: 19.sp),
                      ),
                      Text(
                        '${cartProvider.totalPrice.toStringAsFixed(2)} KWD',
                        style: TextStyle(
                            fontSize: 19.sp,
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
          TextField(
            controller: promoCodeController,
            style: TextStyle(color: tdBlack, fontSize: 12.sp),
            decoration: InputDecoration(
              hintText: 'You Have A Promo Code',
              hintStyle: TextStyle(color: tdBlack, fontSize: 12.sp),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: tdBlack),
                borderRadius: BorderRadius.circular(15.0).w,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: tdBlack),
                borderRadius: BorderRadius.circular(15.0).w,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: tdBlack),
                borderRadius: BorderRadius.circular(15.0).w,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  _applyPromoCode(promoCodeController.text,authProvider.userId);
                },
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Container(
                    width: 70.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: tdBlack),
                      color: tdBlack,
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: tdWhite,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
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
              padding: EdgeInsets.fromLTRB(15.w, 20.h, 15.w, 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Discount',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 12.sp),
                      ),
                      Text(
                        'Final Amount',
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
                        '${savePrice.toStringAsFixed(2)} KWD',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 21.sp),
                      ),
                      Text(
                        '${finalPrice == 0.0 ? orderTotal.toStringAsFixed(2) :finalPrice.toStringAsFixed(2)} KWD',
                        style: TextStyle(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
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
              _createOrder(authProvider.userId, orderTotal, addressProvider.defaultAddressNo);
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
              _createOrder(authProvider.userId, orderTotal, addressProvider.defaultAddressNo);
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
              _createOrder(authProvider.userId, orderTotal, addressProvider.defaultAddressNo);
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
                '*By proceeding, you agree to our',
                style: TextStyle(
                    fontSize: 8.sp,
                    color: tdBlack,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                ' TERMS & CONDITIONS',
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

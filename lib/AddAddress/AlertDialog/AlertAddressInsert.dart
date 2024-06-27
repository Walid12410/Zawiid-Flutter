import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../ApiService/AddressService/AddAddressApi.dart';
import '../../Color&Icons/color.dart';

class AlertUserAddressAdded {
  final AddingAddress addingAddress = AddingAddress();

  Future<void> userAddress(
      BuildContext context,
      String contactPhoneNum,
      String? gov,
      String? area,
      String block,
      String street,
      String building,
      String floor,
      int userNo,
      int isCheckOut) async {

    final result = await addingAddress.insertAddress(
        contactPhoneNum, gov, area, block, street, building, floor, userNo);
    if (result['success']) {
      if (isCheckOut == 1) {
        context.push(context.namedLocation('shippingAddress'));
      } else {
        context.goNamed("AddressView");
      }
    } else {
      _showLoginFailedDialog(context, result['message']);
    }
  }

  void _showLoginFailedDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 15.sp,
              color: tdBlack,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            message,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: tdBlack,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200.w),
                  color: tdBlack,
                ),
                padding: EdgeInsets.all(8.0.w),
                child: Center(
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: tdWhite,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

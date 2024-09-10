import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../Color&Icons/color.dart';
import '../../provider/Cart_Provider.dart';
import 'package:intl/intl.dart';
import 'package:zawiid/generated/l10n.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}


void showDeleteConfirmationDialog(BuildContext context, int userID, int productId) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      bool isDeleting = false;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20).w,
            ),
            backgroundColor: tdWhite,
            surfaceTintColor: tdWhite,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.of(context).areYouSure,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  S.of(context).toRemoveItem,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: isDeleting ? null : () async {
                        setState(() {
                          isDeleting = true;
                        });

                        try {
                          cartProvider.removeFromCart(productId);
                          await cartProvider.deleteCartItem(userID, productId);
                        } catch (error) {
                          _showErrorSnackBar(context,S.of(context).failedToDelete);
                        } finally {
                          setState(() {
                            Navigator.of(context).pop();
                            isDeleting = false;
                          });
                        }
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
                            isDeleting ? S.of(context).processing : S.of(context).yes,
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
            ),
          );
        },
      );
    },
  );
}
void _showErrorSnackBar(BuildContext context, String message) {
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

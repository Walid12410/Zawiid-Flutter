import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Api/AuthService.dart';
import 'package:zawiid/core/Color&Icons/color.dart';

class AlertSignUp {
  final AuthSignUpService _authService = AuthSignUpService();
  bool _isRegistering = false;

  Future<void> register(BuildContext context, String email, String password) async {
    if (_isRegistering) return;

    _isRegistering = true;

    try {
      final result = await _authService.register(email: email, password: password);

      if (result['success']) {
        _showSuccessDialog(context);
      } else {
        _showFailureDialog(context, result['msg']);
      }
    } finally {
      _isRegistering = false;
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Success',
            style: TextStyle(
              fontSize: 15.sp,
              color: tdBlack,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Welcome to Zawid! Please log in to continue.',
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
                GoRouter.of(context).go("/SignIn");
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

  void _showFailureDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Fail Registration',
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

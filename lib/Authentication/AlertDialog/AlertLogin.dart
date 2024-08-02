import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../ApiService/AuthService/AuthLogin.dart';
import '../../Color&Icons/color.dart';
import '../../FirebaseApi/firebase_api.dart';

class AlertLogin {
  final AuthLoginService _authService = AuthLoginService();
  bool _isLoggingIn = false;

  Future<void> login(BuildContext context, String username, String password) async {
    if (_isLoggingIn) return;

    _isLoggingIn = true;

    try {
      final result = await _authService.login(username, password, context);

      if (result['success']) {
        FirebaseApi().initNotifications(context);
        GoRouter.of(context).go("/home");
      } else {
        _showLoginFailedDialog(context, result['message']);
      }
    } finally {
      _isLoggingIn = false;
    }
  }

  void _showLoginFailedDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Login Failed',
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

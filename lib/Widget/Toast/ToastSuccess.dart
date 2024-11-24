import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void showSucessToast(String message, {Color backgroundColor = Colors.green, Color textColor = Colors.white}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 10.sp
  );
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../ApiService/AuthService/AuthLogin.dart';
import '../../Color&Icons/color.dart';

class AlertLogin{
  final AuthLoginService _authService = AuthLoginService();

  Future<void> login(BuildContext context, String username,
      String password) async {
    final result = await _authService.login(username, password);

    if (result['success']) {
      GoRouter.of(context).go("/home");
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Login Failed',style: TextStyle(fontSize: 15.sp,color: tdBlack,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            content: Text(result['message'],style: TextStyle(fontWeight:FontWeight.w400,fontSize: 12.sp,color: tdBlack),textAlign: TextAlign.center,),
            actions: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200).w,
                      color: tdBlack
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0).w,
                    child: Center(
                      child: Text('OK',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: tdWhite),),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      );
    }
  }

}
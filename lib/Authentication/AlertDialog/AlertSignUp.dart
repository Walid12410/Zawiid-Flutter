import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/ApiService/AuthService/AuthSignUp.dart';

import '../../ApiService/AuthService/AuthLogin.dart';
import '../../Color&Icons/color.dart';

class AlertSigUp {
  final AuthSignUpService _authService = AuthSignUpService();

  Future<void> register(
      BuildContext context, String email, String password) async {
    final result =
        await _authService.register(email: email, password: password);

    if (result['success']) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Success',style: TextStyle(fontSize: 15.sp,color: tdBlack,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            content: Text('Welcome to Zawiid! Please log in to continue.',style: TextStyle(fontWeight:FontWeight.w400,fontSize: 12.sp,color: tdBlack),textAlign: TextAlign.center,),
            actions: [
              GestureDetector(
                onTap: (){
                  GoRouter.of(context).go("/SignIn");
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
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Fail Registration',style: TextStyle(fontSize: 15.sp,color: tdBlack,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            content: Text(result['msg'],style: TextStyle(fontWeight:FontWeight.w400,fontSize: 12.sp,color: tdBlack),textAlign: TextAlign.center,),
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../Color&Icons/color.dart';
import '../../../EmailService/EmailService.dart';
import '../../../provider/AppSetting_Provider.dart';
import '../../../provider/ChatSupport_Provider.dart';
import '../../../provider/User_Provider.dart';

class ServiceOptionCard extends StatelessWidget {
  const ServiceOptionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ChatSupportProvider chat = Provider.of<ChatSupportProvider>(context, listen: true);
    final setting = Provider.of<SettingsProvider>(context, listen: true);
    var appSetting = setting.settings.first;
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    var userDetails = userProvider.userInfo.first;

     void errorMessage(String text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text,style: TextStyle(fontSize: 10.sp,color: tdWhite),),
          duration: const Duration(seconds: 2),
          backgroundColor: tdBlack,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(5.0).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: tdWhite,
              borderRadius: BorderRadius.circular(15).w,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(0, 0),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12).w,
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: 52.h,
                    width: 71.w,
                    child: Image.asset(
                      'assets/img/CustomerService/mail.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  GestureDetector(
                    onTap: () {
                      sendEmailSupport(appSetting.email);
                    },
                    child: Container(
                      width: 140.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20).w,
                          color: tdWhiteNav),
                      child: Center(
                        child: Text(
                          'Email Us',
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: tdBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: tdWhite,
              borderRadius: BorderRadius.circular(15).w,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(0, 0),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12).w,
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: 54.h,
                    width: 74.w,
                    child: Image.asset(
                      'assets/img/CustomerService/speech.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 5.sp),
                  GestureDetector(
                    onTap: () {
                      var chatRoom = chat.chatRoom;
                      if(chatRoom.isNotEmpty){
                        if(userDetails.firstName != "" && userDetails.lastName != ""){
                          context.push(context.namedLocation(
                              'ChatPage',
                              pathParameters: {
                                'chatRoomId':
                                chatRoom[0].chatRoomID.toString()
                              }));
                        }else{
                          errorMessage("Please update your profile with your first and last name.");
                        }
                      }else{
                        errorMessage('Please update your profile with your first and last name.');
                      }
                    },
                    child: Container(
                      width: 140.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20).w,
                          color: tdWhiteNav),
                      child: Center(
                        child: Text(
                          'Chat Now',
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: tdBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

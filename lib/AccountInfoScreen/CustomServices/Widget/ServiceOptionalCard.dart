import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../Color&Icons/color.dart';
import '../../../EmailService/EmailService.dart';
import '../../../provider/ChatSupport_Provider.dart';

class ServiceOptionCard extends StatelessWidget {
  const ServiceOptionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                      sendEmailSupport();
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
                      showCustomDialog(context);
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
  void showCustomDialog(BuildContext context) {
    ChatSupportProvider chat = Provider.of<ChatSupportProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: tdWhite,
          backgroundColor: tdWhite,
          title: Text('Contact Us',style: TextStyle(fontSize: 15.sp,color: tdBlack,fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: SvgPicture.asset('assets/svg-profile/whatsapp.svg',width: 18.w,height: 20.h,
                  fit: BoxFit.cover,color: tdGreen,),
                  title: Text('Chat on WhatsApp',style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 12.sp,color: tdBlack),),
                  onTap: () {
                    // Add action to open WhatsApp
                  },
                ),
                ListTile(
                  leading: Icon(Icons.chat_outlined, color: tdBlack,size: 20.w,),
                  title: Text('Start In-App Chat',style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 12.sp,color: tdBlack),),
                  onTap: () {
                    var chatRoom = chat.chatRoom;
                    if(chatRoom.isNotEmpty){
                      context.push(context.namedLocation(
                          'ChatPage',
                          pathParameters: {
                            'chatRoomId':
                            chatRoom[0].chatRoomID.toString()
                          }));
                    }
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel',style: TextStyle(fontWeight: FontWeight.bold,color: tdBlack,fontSize: 12.sp),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}

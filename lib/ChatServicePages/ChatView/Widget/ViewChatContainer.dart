import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/ApiService/MessageService/DeleteChatFromUserApi.dart';

import '../../../Color&Icons/color.dart';
import '../../../provider/ChatSupport_Provider.dart';


class ViewChatContainer extends StatefulWidget {
  const ViewChatContainer({super.key,
  required this.chatTime,
    required this.chatTitle,
    required this.chatID

  });

  final String chatTitle;
  final DateTime chatTime;
  final int chatID;

  @override
  State<ViewChatContainer> createState() => _ViewChatContainerState();
}

class _ViewChatContainerState extends State<ViewChatContainer> {

  void _deleteChatRoom(BuildContext context) {
    ChatSupportProvider chatProvider = Provider.of<ChatSupportProvider>(context, listen: false);
    bool isLoading = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25).w,
            ),
            backgroundColor: tdWhite,
            surfaceTintColor: tdWhite,
            contentPadding:const EdgeInsets.symmetric(horizontal: 20, vertical: 20).w,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Are you sure you want to delete this chat room?',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: tdBlack,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: isLoading ? null : () async {
                        setState(() {
                          isLoading = true;
                        });
                        bool isDeleted = await updateUserDeleteChat(widget.chatID.toString());
                        if (isDeleted) {
                          chatProvider.removeFromChatRoom(widget.chatID);
                          setState((){
                            Navigator.of(context).pop(); // Close the dialog
                          });
                        } else {
                          _showErrorSnackBar("Something went wrong");
                          setState((){
                            Navigator.of(context).pop(); // Close the dialog
                          });
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Container(
                        width: 100.w,
                        padding:const  EdgeInsets.all(5).w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: tdWhite,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            isLoading ? "Loading..." : 'YES',
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
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Container(
                        width: 100.w,
                        padding: const EdgeInsets.all(8).w,
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
                            'NO',
                            style: TextStyle(
                              fontSize: 9.sp,
                              color: tdWhite,
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

        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5).w,
      child: GestureDetector(
        onTap: (){
          GoRouter.of(context).goNamed('ChatPage',pathParameters: {
            'chatRoomId' : widget.chatID.toString(),
          });
        },
        onLongPress: (){
          _deleteChatRoom(context);
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12).w,
              color: tdWhiteNav
          ),
          child: Padding(
            padding: const EdgeInsets.all(5).w,
            child: Row(
              children: [
                Icon(Icons.support_agent,size: 30.w,color: tdBlack,),
                SizedBox(width: 5.w,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.chatTitle,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: tdBlack, // Replace with `tdBlack` if defined
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            formatDateTime(widget.chatTime),
                            style: TextStyle(
                              fontSize: 8.sp,
                              color: tdBlack, // Replace with `tdBlack` if defined
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h), // Optional space between rows
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
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

  String formatDateTime(DateTime date) {
    final DateFormat dateFormatter = DateFormat('d MMM yyyy');
    final DateFormat timeFormatter = DateFormat('h:mm a');
    return '${dateFormatter.format(date)} . ${timeFormatter.format(date)}';
  }
}




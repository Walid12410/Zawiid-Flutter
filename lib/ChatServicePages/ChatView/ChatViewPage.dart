import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Widget/PageHeadWidget.dart';

import '../../Color&Icons/color.dart';
import 'Widget/ViewChatContainer.dart';


class ChatViewPage extends StatefulWidget {
  const ChatViewPage({super.key});

  @override
  State<ChatViewPage> createState() => _ChatViewPageState();
}

class _ChatViewPageState extends State<ChatViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              PageHeadView(title: 'Chat Service', onPressed: (){
                context.pop();
              }),
              ViewChatContainer(),
              ViewChatContainer(),
              ViewChatContainer()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        backgroundColor: tdBlack,
        child: Icon(
          Icons.add_comment_rounded,
          color: tdWhite,
          size: 18.w,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}


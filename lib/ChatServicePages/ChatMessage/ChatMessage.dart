import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import '../../provider/ChatSupport_Provider.dart';

class ChatPage extends StatefulWidget {
  final int chatRoomId;

  ChatPage({required this.chatRoomId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  late ChatSupportProvider chatSupportProvider;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    chatSupportProvider = Provider.of<ChatSupportProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatSupportProvider.fetchMessages(widget.chatRoomId);
      chatSupportProvider.startFetchingMessages(widget.chatRoomId);
      _focusNode.requestFocus();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatSupportProvider.fetchMessages(widget.chatRoomId);
      chatSupportProvider.startFetchingMessages(widget.chatRoomId);
    });
  }

  @override
  void dispose() {
    chatSupportProvider.stopFetchingMessages();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatSupportProvider = Provider.of<ChatSupportProvider>(context, listen: true);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: tdWhite,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Customer Support',
          style: TextStyle(
              fontSize: 12.sp, color: tdBlack, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Image.asset(
            'assets/img/pop.png', // Replace with your image asset path
            width: 20.w,
            height: 18.h,
          ),
          onPressed: () {
            GoRouter.of(context).goNamed('ChatViewPage');
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: chatSupportProvider.messages.isEmpty || chatSupportProvider.messages.any((msg) => msg.chatRoomId != widget.chatRoomId)
                  ? Center(
                child: Text(
                  chatSupportProvider.messages.isEmpty
                      ? 'No messages yet'
                      : 'Invalid chat room',
                  style: TextStyle(fontSize: 16.sp, color: tdBlack),
                ),
              )
                  : ListView.builder(
                reverse: true,
                itemCount: chatSupportProvider.messages.length,
                itemBuilder: (context, index) {
                  if (index == chatSupportProvider.messages.length - 1) {
                    return Column(
                      children: [
                        _buildDateHeader(
                            chatSupportProvider.messages[index].sentAt),
                        _buildMessage(chatSupportProvider, authProvider, index),
                      ],
                    );
                  }

                  bool isNewDay = _isNewDay(
                    chatSupportProvider.messages[index].sentAt,
                    chatSupportProvider.messages[index + 1].sentAt,
                  );

                  return Column(
                    children: [
                      if (isNewDay)
                        _buildDateHeader(
                            chatSupportProvider.messages[index].sentAt),
                      _buildMessage(chatSupportProvider, authProvider, index),
                    ],
                  );
                },
              ),
            ),
            _buildMessageInput()
          ],
        ),
      ),
    );
  }

  bool _isNewDay(DateTime currentMessageDate, DateTime nextMessageDate) {
    return currentMessageDate.day != nextMessageDate.day ||
        currentMessageDate.month != nextMessageDate.month ||
        currentMessageDate.year != nextMessageDate.year;
  }

  Widget _buildDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(date.year, date.month, date.day);

    String dateText;
    if (messageDate == today) {
      dateText = 'Today';
    } else if (messageDate == yesterday) {
      dateText = 'Yesterday';
    } else {
      dateText = DateFormat.yMMMd().format(date);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10).w,
      child: Center(
        child: Text(
          dateText,
          style: TextStyle(
              fontSize: 12.sp,
              color: tdGrey,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(ChatSupportProvider chatSupportProvider,
      AuthProvider authProvider, int index) {
    final message = chatSupportProvider.messages[index];
    final isMe = message.senderId == authProvider.userId;
    final DateTime sentAtDateTime = DateTime.parse(message.sentAt.toString());
    final String formattedTime = DateFormat.jm().format(sentAtDateTime);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            color: isMe ? tdBlack : tdWhiteNav,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15).w,
              topRight: const Radius.circular(15).w,
              bottomLeft: const Radius.circular(15).w,
            )),
        padding: const EdgeInsets.all(8).w,
        margin: const EdgeInsets.all(3).w,
        child: Column(
          crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.messageText,
              style:
              TextStyle(color: isMe ? tdWhite : tdBlack, fontSize: 10.sp),
            ),
            SizedBox(height: 2.h),
            Text(
              formattedTime,
              style: TextStyle(
                  color: isMe ? Colors.white70 : Colors.black54,
                  fontSize: 8.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    final chatSupportProvider = Provider.of<ChatSupportProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(5.0).w,
      child: Row(
        children: [
          Expanded(
              child: TextField(
                focusNode: _focusNode,
                controller: _controller,
                cursorColor: tdWhite,
                style:  TextStyle(color: tdWhite,fontSize: 12.sp), // Text color
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  hintStyle: TextStyle(color: tdWhite,fontSize: 12.sp,fontWeight: FontWeight.bold), // Hint text color
                  filled: true,
                  fillColor: tdBlack, // Background color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10).w,
                    borderSide: const BorderSide(color: tdBlack), // Border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10).w,
                    borderSide: const BorderSide(color: tdBlack), // Border color when enabled
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10).w,
                    borderSide:const BorderSide(color: tdBlack), // Border color when focused
                  ),
                ),
              )

          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: tdBlack,
              size: 20.w,
            ),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                chatSupportProvider.sendMessage(
                  widget.chatRoomId,
                  authProvider.userId, // Adjust senderId as needed
                  _controller.text,
                );
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}

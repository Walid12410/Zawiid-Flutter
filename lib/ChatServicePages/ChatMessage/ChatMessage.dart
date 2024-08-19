import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:intl/intl.dart'; // For formatting time

import '../../Color&Icons/color.dart';
import '../../provider/User_Provider.dart';

class ChatPage extends StatefulWidget {
  final int chatRoomId;

  ChatPage({required this.chatRoomId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  IO.Socket? socket;
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = []; // Store messages with text, username, and time
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userDetails = userProvider.userInfo.first; // Assuming 'username' is a field in UserProvider
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _focusNode.requestFocus();
      _scrollToBottom();
    });
    _connectSocket('${userDetails.firstName} ${userDetails.lastName}');
  }

  void _connectSocket(String name) {
    socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket?.connect();

    socket?.onConnect((_) {
      socket?.emit('joinRoom', {
        'username': name,
        'room': widget.chatRoomId.toString(),
      });
    });

    socket?.on('message', (data) {
      print('Message received: $data'); // Debug to check the structure of data

      // Check if the received data is in the expected map format
      if (data is Map<String, dynamic> &&
          data.containsKey('text') &&
          data.containsKey('username') &&
          data.containsKey('time')) {
        setState(() {
          _messages.add({
            'username': data['username'],
            'text': data['text'],
            'time': data['time'],
          });
        });
      } else {
        print(
            'Unexpected message format: $data'); // Fallback for unexpected data structure
      }
    });

    socket?.onDisconnect((_) {
      print('Disconnected');
    });

    socket?.onError((error) {
      print('Socket error: $error');
    });
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      String formattedTime = DateFormat('hh:mm a')
          .format(DateTime.now()); // Format time as '01:09 AM'

      socket?.emit('chatMessage', _messageController.text);

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userDetails = userProvider
        .userInfo.first; // Assuming 'username' is a field in UserProvider
    String currentUser = '${userDetails.firstName} ${userDetails.lastName}';

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
            'assets/img/pop.png',
            width: 20.w,
            height: 18.h,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isCurrentUser = message['username'] == currentUser;

                return Align(
                  alignment: isCurrentUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 3.0,
                      horizontal: 7.0,
                    ).w,
                    padding: const EdgeInsets.all(7.0).w,
                    decoration: BoxDecoration(
                      color: isCurrentUser ? tdBlack : tdWhiteNav,
                      borderRadius: isCurrentUser
                          ? BorderRadius.only(
                              topLeft: const Radius.circular(15).w,
                              topRight: const Radius.circular(15).w,
                              bottomLeft: const Radius.circular(15).w,
                            )
                          : BorderRadius.only(
                              topLeft: const Radius.circular(15).w,
                              topRight: const Radius.circular(15).w,
                              bottomRight: const Radius.circular(15).w,
                            ),
                    ),
                    child: Column(
                      crossAxisAlignment: isCurrentUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        if (!isCurrentUser)
                          Text(
                            message['username']!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 12.sp),
                          ),
                        Text(
                          message['text']!,
                          style: TextStyle(
                              color: isCurrentUser ? tdWhite : tdBlack,
                              fontSize: 12.sp),
                        ),
                        SizedBox(height: 2.0.h),
                        Text(
                          message['time']!,
                          style: TextStyle(
                            fontSize: 7.sp,
                            color: tdGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0).w,
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  focusNode: _focusNode,
                  controller: _messageController,
                  cursorColor: tdWhite,
                  style: TextStyle(color: tdWhite, fontSize: 12.sp),
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    hintStyle: TextStyle(
                        color: tdWhite,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                    filled: true,
                    fillColor: tdBlack,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10).w,
                      borderSide: const BorderSide(color: tdBlack),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10).w,
                      borderSide: const BorderSide(color: tdBlack),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10).w,
                      borderSide: const BorderSide(color: tdBlack),
                    ),
                  ),
                )),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: tdBlack,
                    size: 20.w,
                  ),
                  onPressed: () {
                    _sendMessage();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    socket?.disconnect();
    socket?.dispose();
    super.dispose();
  }
}

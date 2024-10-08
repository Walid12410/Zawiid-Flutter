import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/provider/ChatSupport_Provider.dart';
import 'package:zawiid/provider/User_Provider.dart';

class ChatPage extends StatefulWidget {
  final int chatRoomId;

  ChatPage({required this.chatRoomId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  IO.Socket? socket;
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = []; // Store real-time messages
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userDetails = userProvider.userInfo.first;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _focusNode.requestFocus();
      _scrollToBottom();
    });
    _connectSocket('${userDetails.firstName} ${userDetails.lastName}');
  }

  void _connectSocket(String name) {
    socket = IO.io('http://jawaher.app:49152', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket?.connect();

    socket?.onConnect((_) {
      socket?.emit('joinRoom', {
        'username': name,
        'room': 21.toString(),
      });
    });

    socket?.on('message', (data) {
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
        _scrollToBottom(); // Scroll to bottom when a new message is received
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
      socket?.emit('chatMessage', _messageController.text);
      _messageController.clear();
    }
  }

  Future<void> _fetchData() async {
    final messageHistory =
        Provider.of<ChatSupportProvider>(context, listen: false);
    messageHistory.fetchMessages(widget.chatRoomId);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final messageHistory =
        Provider.of<ChatSupportProvider>(context, listen: true);
    final userDetails = userProvider.userInfo.first;
    String currentUser = '${userDetails.firstName} ${userDetails.lastName}';
    var oldMessage = messageHistory.messagesHistory;

    List<dynamic> combinedMessages = [...oldMessage, ..._messages];

    return Scaffold(
      backgroundColor: tdWhite,
      appBar: AppBar(
        surfaceTintColor: tdWhite,
        backgroundColor: tdWhite,
        shadowColor: tdWhite,
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
      body: FutureBuilder(
          future: _fetchDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: tdBlack,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Something went wrong, check your connection.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                    color: tdGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: combinedMessages.length,
                      itemBuilder: (context, index) {
                        final message = combinedMessages[index];

                        final isOldMessage = index < oldMessage.length;

                        final bool isCurrentUser = isOldMessage
                            ? message.senderId == userDetails.userNo
                            : message['username'] == currentUser;

                        final String messageText = isOldMessage
                            ? message.messageText
                            : message['text'] ?? '';

                        final String messageSender = isOldMessage
                            ? "Support"
                            : message['username'] ?? '';

                        final String messageTime = isOldMessage
                            ? DateFormat('HH:mm').format(message.sentAt)
                            : message['time'] ?? '';

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
                                    messageSender,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        fontSize: 12.sp),
                                  ),
                                Text(
                                  messageText,
                                  style: TextStyle(
                                      color: isCurrentUser ? tdWhite : tdBlack,
                                      fontSize: 12.sp),
                                ),
                                SizedBox(height: 2.0.h),
                                Text(
                                  messageTime,
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
                            messageHistory.sendMessage(widget.chatRoomId,
                                userDetails.userNo, _messageController.text);
                            _sendMessage();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          }),
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

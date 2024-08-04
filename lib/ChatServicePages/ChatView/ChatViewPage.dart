import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/ApiService/MessageService/CreateRoomApi.dart';
import 'package:zawiid/Widget/PageHeadWidget.dart';
import 'package:zawiid/provider/ChatSupport_Provider.dart';

import '../../Color&Icons/color.dart';
import '../../provider/Auth_Provider.dart';
import 'Widget/ViewChatContainer.dart';

class ChatViewPage extends StatefulWidget {
  const ChatViewPage({super.key});

  @override
  State<ChatViewPage> createState() => _ChatViewPageState();
}

class _ChatViewPageState extends State<ChatViewPage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _reportController = TextEditingController();
  late Future<void> _chatFuture;

  void _problemDialog() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _focusNode.requestFocus();
            });

            return AlertDialog(
              backgroundColor: tdWhite,
              surfaceTintColor: tdWhite,
              title: Text(
                'Report a problem',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: tdBlack),
              ),
              content: TextField(
                controller: _reportController,
                cursorColor: tdBlack,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: "What's the issue?",
                  hintStyle: TextStyle(color: tdBlack, fontSize: 10.sp),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: tdBlack),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: tdBlack),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: tdBlack),
                  ),
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: isLoading
                          ? null
                          : () async {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                bool isCreated = await createRoomChat(
                                    chatRoomTitle: _reportController.text,
                                    userID: authProvider.userId);
                                if (isCreated) {
                                  _reportController.clear();
                                  Navigator.of(context).pop();
                                } else {
                                  _showErrorSnackBar("Something went wrong");
                                  Navigator.of(context).pop();
                                }
                              } catch (e) {
                                _showErrorSnackBar("Something went wrong");
                                Navigator.of(context).pop();
                              } finally {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                      child: Container(
                        width: 100.w,
                        padding: EdgeInsets.all(8.w),
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
                            isLoading ? "Loading..." : 'Report',
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
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 100.w,
                        padding: EdgeInsets.all(8.w),
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
                            'Cancel',
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
            );
          },
        );
      },
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

  @override
  void initState() {
    super.initState();
    _chatFuture = _fetchChatRoom();

  }
  Future<void> _fetchChatRoom() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    ChatSupportProvider chatProvider = Provider.of<ChatSupportProvider>(context, listen: false);
    await chatProvider.getAllChatRoom(authProvider.userId);
  }



  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatSupportProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: FutureBuilder(
          future: _chatFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: tdBlack,
              ));
            } else if (snapshot.hasError) {
              return Center(
                  child: Text(
                'Something went wrong, Check your connection.',
                style: TextStyle(
                    fontSize: 12.sp,
                    color: tdGrey,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ));
            } else if (chatProvider.allChatRoom.isEmpty) {
              return Center(
                  child: Text(
                'No chat rooms',
                style: TextStyle(
                    fontSize: 12.sp,
                    color: tdGrey,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ));
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    PageHeadView(
                      title: 'Chat Service',
                      onPressed: () {
                        context.pop();
                      },
                    ),
                    ...chatProvider.allChatRoom
                        .map((chatRoom) => ViewChatContainer(
                              chatTime: chatRoom.createdAt,
                              chatTitle: chatRoom.chatRoomTitle,
                              chatID : chatRoom.chatRoomID
                            ))
                        .toList(),
                  ],
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _problemDialog();
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

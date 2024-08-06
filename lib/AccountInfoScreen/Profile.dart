import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/provider/ChatSupport_Provider.dart';
import '../ConnectivityCheck.dart';
import '../provider/Auth_Provider.dart';
import '../provider/User_Provider.dart';
import 'Widget/GuestView.dart';
import 'Widget/ProfileMainWidget.dart';

class ProfileMain extends StatefulWidget {
  const ProfileMain({super.key});

  @override
  State<ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  late Future<void> _fetchUserInfoFuture;
  late StreamSubscription _connectionChangeStream;
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    _connectionChangeStream = connectionStatus.connectionChange.listen(connectionChanged);
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    ChatSupportProvider chat = Provider.of<ChatSupportProvider>(context, listen: false);
    UserProvider userDetails = Provider.of<UserProvider>(context, listen: false);
    chat.getChatRoom(authProvider.userId);
    _fetchUserInfoFuture = userDetails.getUserInfo(authProvider.userId);
  }

  void connectionChanged(dynamic hasConnection) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    UserProvider userDetails = Provider.of<UserProvider>(context, listen: false);
    setState(() {
      isOffline = !hasConnection;
      if (!isOffline) {
        _fetchUserInfoFuture = userDetails.getUserInfo(authProvider.userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchUserInfoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  const Center(
            child: CircularProgressIndicator(
              color: tdBlack,
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: tdWhite,
            body: Center(
              child: Text(
                'Something went wrong. check your connection',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: tdGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else {
          UserProvider userDetails = Provider.of<UserProvider>(context, listen: false);
          var userInfo = userDetails.userInfo;
          if (userInfo.isEmpty || userInfo[0].userNo == 0) {
            return const Scaffold(
              backgroundColor: tdWhite,
              body: SafeArea(
                child: GuestViewProfile(),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: tdWhite,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8).w,
                    child: const ProfileMainWidget(),
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }
}



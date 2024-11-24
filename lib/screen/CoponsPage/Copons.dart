import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Widget/Header.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/core/ConnectivityCheck.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/provider/Coupons_Provider.dart';
import 'Details/CouponsListMark.dart';
import 'Details/LoadingContainerCoupons.dart';

class CouponsMain extends StatefulWidget {
  const CouponsMain({Key? key}) : super(key: key);

  @override
  State<CouponsMain> createState() => _CouponsMainState();
}

class _CouponsMainState extends State<CouponsMain> {
  late Future<void> _fetchCouponsFuture;
  late StreamSubscription _connectionChangeStream;
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    _connectionChangeStream = connectionStatus.connectionChange.listen(connectionChanged);
    _fetchCouponsFuture = _fetchCoupons();

  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
      if (!isOffline) {
        _fetchCouponsFuture = _fetchCoupons();
      }
    });
  }


  Future<void> _fetchCoupons() async {
    final couponsProvider = Provider.of<CouponsProvider>(context, listen: false);
    await couponsProvider.getAllCouponsMark();
  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchCouponsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingContainerCoupons();
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              S.of(context).errorConnection,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: tdGrey,
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return _buildCouponsList();
        }
      },
    );
  }

  Widget _buildCouponsList() {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              PageHeadView(title: S.of(context).coupons, onPressed: (){
                GoRouter.of(context).go("/home");
              }),
              SizedBox(height: 15.h),
              const CouponsListView(),
            ],
          ),
        ),
      ),
    );
  }
}



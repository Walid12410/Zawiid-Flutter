import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/Widget/PageHeadWidget.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/OrderProvider.dart';

import 'Widget/OrderViewDetails.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  late Future<void> _fetchOrderDetails;

  @override
  void initState() {
    super.initState();
    _fetchOrderDetails = _fetchOrder();
  }

  Future<void> _fetchOrder() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    await orderProvider.getOrderByUser(auth.userId);
    print('asdadsasd');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
          child: FutureBuilder(
              future: _fetchOrderDetails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(color: tdBlack));
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Something went wrong. Check your connection',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: tdGrey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return  SingleChildScrollView(
                    child: Column(
                      children: [
                        PageHeadView(title: 'All My Orders',onPressed: (){
                          GoRouter.of(context).go("/Profile");
                        },),
                        const OrderViewDetails(),
                      ],
                    ),
                  );
                }
              })),
    );
  }
}

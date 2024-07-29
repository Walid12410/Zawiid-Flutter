import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/provider/Cart_Provider.dart';

import '../Widget/PageHeadWidget.dart';
import '../provider/Auth_Provider.dart';
import 'Widget/PaymentDetails.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await cartProvider.getAllCartDetailsOfUser(authProvider.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: tdWhite,
            body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(
                  color: tdBlack,
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: tdWhite,
            body: SafeArea(
              child: Center(
                child: Text(
                  'Something went wrong, check you connection.',
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: tdGrey,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }  else {
            return Scaffold(
              backgroundColor: tdWhite,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      PageHeadView(
                        title: 'Payment',
                        onPressed: () {
                          GoRouter.of(context).go("/home");
                        },
                      ),
                      SizedBox(height: 2.h),
                      const PaymentDetails(),
                    ],
                  ),
                ),
              ),
            );
          }
        }
    );
  }
}

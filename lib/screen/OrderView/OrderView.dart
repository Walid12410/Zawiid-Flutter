import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Widget/Header.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/localization/generated/l10n.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/OrderProvider.dart';
import 'Details/OrderViewDetails.dart';

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
                  return  SingleChildScrollView(
                    child: Column(
                      children: [
                        PageHeadView(title: S.of(context).allMyOrders,onPressed: (){
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

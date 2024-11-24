import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/Bid_Provider.dart';
import 'package:zawiid/provider/Products_Provider.dart';
import 'package:zawiid/provider/SelectionMarkColor_Provider.dart';
import 'Details/BidPageDetails.dart';
import 'Details/BidPageHead.dart';
import 'Details/BidPageImage.dart';

import 'Details/LoadingContainerBid.dart';


class BidPage extends StatefulWidget {
  const BidPage(
      {super.key,
      required this.bidNo,
      required this.productNo,
      required this.colorNo});

  final int bidNo;
  final int productNo;
  final int colorNo;

  @override
  State<BidPage> createState() => _BidPageState();
}

class _BidPageState extends State<BidPage> {
  Future<void> _loadData(
    ProductsProvider productById,
    MarkColorProvider colorById,
    BidProvider bidProvider,
    AuthProvider auth,
  ) async {
    try {
      final List<Future<dynamic>> fetchers = [
        bidProvider.getLatestBid(widget.bidNo),
        productById.getProductByIdBid(widget.productNo),
        colorById.getColorByIdBid(widget.colorNo),
        bidProvider.getBidById(widget.bidNo),
        bidProvider.getLatestUserBid(auth.userId, widget.bidNo),
      ];
      final List<dynamic> results = await Future.wait(fetchers);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final productById = Provider.of<ProductsProvider>(context, listen: false);
    final colorById = Provider.of<MarkColorProvider>(context, listen: false);
    final bidProvider = Provider.of<BidProvider>(context, listen: false);
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: FutureBuilder<void>(
          future: _loadData(productById, colorById, bidProvider, auth),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingContainerBid();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                 S.of(context).errorConnection,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: tdGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0).w,
                  child: Column(
                    children: [
                      SizedBox(height: 5.h),
                      const BidPageHead(),
                      const BidPageImage(),
                      const BidPageDetails(),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}


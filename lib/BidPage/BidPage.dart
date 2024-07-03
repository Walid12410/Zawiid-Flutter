import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/provider/Bid_Provider.dart';
import 'package:zawiid/provider/Products_Provider.dart';
import 'package:zawiid/provider/SelectionMarkColor_Provider.dart';
import 'Widget/BidPageDetails.dart';
import 'Widget/BidPageHead.dart';
import 'Widget/BidPageImage.dart';

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
  late Future<void> _fetchData;

  @override
  void initState() {
    super.initState();
    _fetchData = _loadData();
  }

  Future<void> _loadData() async {
    final productById = Provider.of<ProductsProvider>(context, listen: false);
    final colorById = Provider.of<MarkColorProvider>(context, listen: false);
    final bidProvider = Provider.of<BidProvider>(context, listen: false);
    await bidProvider.getLatestBid(widget.bidNo);
    await productById.getProductById(widget.productNo);
    await colorById.getColorByIdBid(widget.colorNo);
    await bidProvider.getBidById(widget.bidNo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: FutureBuilder<void>(
          future: _fetchData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: tdBlack,
              ));
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Something went wrong, check you connection.',
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
                      SizedBox(height: 20.h)
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

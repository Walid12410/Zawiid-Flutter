import 'dart:async';
import 'package:zawiid/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/provider/Bid_Provider.dart';
import '../../ConnectivityCheck.dart';
import 'Widget/DetailsCard.dart';
import '../LoadingContainerUpcoming.dart';

class UpComingTab extends StatefulWidget {
  const UpComingTab({super.key});

  @override
  State<UpComingTab> createState() => _UpComingTabState();
}

class _UpComingTabState extends State<UpComingTab> {
  late Future<void> _bidFuture;
  late StreamSubscription _connectionChangeStream;
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    _connectionChangeStream = connectionStatus.connectionChange.listen(connectionChanged);
    _bidFuture = _fetchBids();
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
      if (!isOffline) {
        _bidFuture = _fetchBids();
      }
    });
  }

  Future<void> _fetchBids() async {
    BidProvider bidProvider = Provider.of<BidProvider>(context, listen: false);
    await bidProvider.getAllBid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: FutureBuilder<void>(
          future: _bidFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingContainerUpcoming();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  S.of(context).errorConnection,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: tdGrey,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              BidProvider bidProvider = Provider.of<BidProvider>(context, listen: true);
              var bidData = bidProvider.bidView;

              if (bidData.isEmpty) {
                return Center(
                  child: Text(
                    S.of(context).noBid,
                    style: TextStyle(fontSize: 15.sp, color: tdGrey),
                  ),
                );
              }

              // Filter bids to include only those not yet sold
              var filteredBids = bidData
                  .where((bid) => bid.soldToUserNo == 0 || bid.soldToUserNo == null)
                  .toList();

              // Sort bids: ended bids should come last
              filteredBids.sort((a, b) {
                bool aEnded = DateTime.now().isAfter(a.bidEndDate);
                bool bEnded = DateTime.now().isAfter(b.bidEndDate);
                if (aEnded && !bEnded) return 1;
                if (!aEnded && bEnded) return -1;
                return 0;
              });

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5.h),
                    for (var bid in filteredBids)
                      DetailsUpComing(
                        bidNo: bid.bidNo,
                        endTime: bid.bidEndDate,
                        startTime: bid.bidStartDate,
                        productNo: bid.productNo,
                        productName: bid.products.isNotEmpty
                            ? bid.products[0].productName
                            : "",
                        startPrice: bid.startPrice,
                        productImage: '${ApiEndpoints.localBaseUrl}/${bid.products[0].productImage}',
                        colorName: bid.products[0].color!.colorName,
                        colorNo: bid.products[0].color!.colorNo,
                      ),
                    SizedBox(height: 10.h),
                  ],
                ),
              );

            }
          },
        ),
      ),
    );
  }
}


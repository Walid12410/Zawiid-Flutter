import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/provider/Bid_Provider.dart';
import 'Widget/DetailsCard.dart';

class UpComingTab extends StatefulWidget {
  const UpComingTab({super.key});

  @override
  State<UpComingTab> createState() => _UpComingTabState();
}

class _UpComingTabState extends State<UpComingTab> {
  late Future<void> _bidFuture;

  @override
  void initState() {
    super.initState();
    _bidFuture = _fetchBids();
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
                    fontSize: 15.sp,
                    color: tdGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              BidProvider bidProvider =
              Provider.of<BidProvider>(context, listen: true);
              var bidData = bidProvider.bidView;

              if (bidData.isEmpty) {
                return Center(
                  child: Text(
                    "No bid added yet",
                    style: TextStyle(fontSize: 15.sp, color: tdGrey),
                  ),
                );
              }

              var filteredBids = bidData
                  .where((bid) => bid.soldToUserNo == 0 || bid.soldToUserNo == null)
                  .toList();

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

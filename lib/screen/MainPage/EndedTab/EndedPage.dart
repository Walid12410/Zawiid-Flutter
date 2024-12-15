import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/provider/Bid_Provider.dart';
import 'package:zawiid/screen/MainPage/LoadingContainerUpcoming.dart';
import 'Details/SoldDetail.dart';

class EndedTab extends StatefulWidget {
  const EndedTab({Key? key}) : super(key: key);

  @override
  State<EndedTab> createState() => _EndedTabState();
}

class _EndedTabState extends State<EndedTab> {
  late Future<void> _bidFuture;

  @override
  void initState() {
    super.initState();
    _bidFuture = _fetchBids();
  }

  Future<void> _fetchBids() async {
    BidProvider bidProvider = Provider.of<BidProvider>(context, listen: false);
    await bidProvider.getEndedBid();
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
              BidProvider bidProvider =
                  Provider.of<BidProvider>(context, listen: true);
              var bidData = bidProvider.endedBid;

              if (bidData.isEmpty) {
                return Center(
                  child: Text(
                    S.of(context).noBid,
                    style: TextStyle(fontSize: 15.sp, color: tdGrey),
                  ),
                );
              }

              var filteredBids = bidData.where(
                  (bid) => bid.soldToUserNo != null && bid.soldToUserNo != 0);

              if (filteredBids.isEmpty) {
                return Center(
                  child: Text(
                    S.of(context).nothingSold,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: tdGrey,
                        fontSize: 15.sp),
                  ),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5.h),
                    for (var bid in filteredBids)
                      SolidCard(endedBid: bid),
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

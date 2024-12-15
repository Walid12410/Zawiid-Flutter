import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/core/ConnectivityCheck.dart';
import 'package:zawiid/core/config.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/provider/Bid_Provider.dart';
import 'Details/DetailsCard.dart';
import '../LoadingContainerUpcoming.dart';

class UpComingTab extends StatefulWidget {
  const UpComingTab({super.key});

  @override
  State<UpComingTab> createState() => _UpComingTabState();
}

class _UpComingTabState extends State<UpComingTab> {
  late ScrollController _scrollController;
  late BidProvider bidProvider;
  late StreamSubscription _connectionChangeStream;
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    _connectionChangeStream = connectionStatus.connectionChange.listen(connectionChanged);
    _scrollController = ScrollController()..addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bidProvider.getAllBid();
    });
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 200) {
      Provider.of<BidProvider>(context, listen: false).getAllBid();
    }
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
      if (!isOffline) {
        bidProvider.getAllBid();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bidProvider = Provider.of<BidProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    bidProvider.resetBid();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: Consumer<BidProvider>(builder: (context , bidProvider , child){
        if(bidProvider.isLoading && bidProvider.bidProduct.isEmpty){
          return const Center(
            child: CircularProgressIndicator(color: tdBlack,),
          );
        }

        if(bidProvider.bidProduct.isEmpty){
          return Center(
            child: Text(
              S.of(context).noBid,
              style: TextStyle(
                  fontSize: 15.sp,
                  color: tdBlack,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        }

        return ListView.builder(
          controller: _scrollController,
          itemCount: bidProvider.bidProduct.length + (bidProvider.hasMoreData ? 1 : 0),
          itemBuilder: (context, index) {
            if(index == bidProvider.bidProduct.length) {
              return const Center(
                child: CircularProgressIndicator(color: tdBlack),
              );
            }

            final bid = bidProvider.bidProduct[index];
            return UpComingCard(bid: bid);
          });
      })
    );
  }
}


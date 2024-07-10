import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/provider/Coupons_Provider.dart';
import '../../provider/SelectionMarkColor_Provider.dart';
import 'Widget/CouponsCardDetails.dart';
import 'Widget/CouponsCardHead.dart';
import 'Widget/TitleAndDescriptionCoupons.dart';

class CouponsDetails extends StatefulWidget {
  const CouponsDetails({
    Key? key,
    required this.markId,
    required this.couponId,
  }) : super(key: key);

  final int markId;
  final int couponId;

  @override
  State<CouponsDetails> createState() => _CouponsDetailsState();
}

class _CouponsDetailsState extends State<CouponsDetails> {
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    final markProvider = Provider.of<MarkColorProvider>(context, listen: false);
    final couponsProvider = Provider.of<CouponsProvider>(context, listen: false);
    await markProvider.getMarkByIdCoupons(widget.markId);
    await couponsProvider.getCouponsByMarkId(widget.markId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: FutureBuilder(
          future: _fetchDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: tdBlack,));
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
              return _buildContent();
            }
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CouponsCardHead(),
          const TitleAndDescription(),
          Padding(
            padding: const EdgeInsets.all(5).w,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: tdWhite,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: const Offset(4.0, 4.0),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5).w,
                child: Column(
                  children:  [
                    const CouponsCardDetails(),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

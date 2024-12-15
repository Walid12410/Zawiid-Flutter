import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Widget/Header.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/core/config.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/Coupons_Provider.dart';
import 'package:zawiid/provider/SelectionMarkColor_Provider.dart';
import 'package:zawiid/screen/CoponsListPage/Details/CouponsCard.dart';
import '../../Widget/LoadingScreen/LoadingContainerCouponsDetails.dart';

class CouponsList extends StatefulWidget {
  const CouponsList({
    Key? key,
    required this.markId,
  }) : super(key: key);

  final int markId;

  @override
  State<CouponsList> createState() => _CouponsListState();
}

class _CouponsListState extends State<CouponsList> {
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    final couponsProvider = Provider.of<CouponsProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final markProvider = Provider.of<MarkColorProvider>(context, listen: false);
    await markProvider.getMarkByIdCoupons(widget.markId);
    await couponsProvider.getCouponsByMarkId(widget.markId);
    await couponsProvider.getUserCoupons(authProvider.userId);

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
              return const LoadingContainerCouponsDetails();
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
              return _buildContent();
            }
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    final couponsProvider = Provider.of<CouponsProvider>(context, listen: true);
    final markProvider = Provider.of<MarkColorProvider>(context, listen: true);
    var coupons = couponsProvider.coupons;
    var mark = markProvider.oneMarkByIDCoupons.first;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeadView(
              title: S.of(context).coupons,
              onPressed: () {
                GoRouter.of(context).go("/Coupons");
              }),
          Padding(
            padding: const EdgeInsets.all(10).w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120.w,
                  height: 80.h,
                  child: CachedNetworkImage(
                    imageUrl: '${ApiEndpoints.localBaseUrl}/${mark.markImage}',
                    placeholder: (context, url) =>
                        Image.asset('assets/log/LOGO-icon---Black.png'),
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/log/LOGO-icon---Black.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Text(
                      mark.markName,
                      style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: tdBlack),
                    ),
                    Text(
                      ' ${S.of(context).couponAndPromoCodes}',
                      style: TextStyle(fontSize: 11.sp, color: tdGrey),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  mark.markDesc,
                  style: TextStyle(fontSize: 8.sp, color: tdBlack),
                ),
              ],
            ),
          ),
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
                  children: [
                    if (coupons.isEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0).w,
                        child: Center(
                          child: Text(
                            S.of(context).noCouponsAdded,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: tdGrey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ] else ...[
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: coupons.length,
                        itemBuilder: (context, index) {
                          var coupon = coupons[index];
                          return CouponCard(coupon: coupon);
                        },
                      )
                    ],
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

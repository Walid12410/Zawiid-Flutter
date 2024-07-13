import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:zawiid/ApiService/CouponsService/GetCouponsApi.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import '../../../ApiService/CouponsService/CouponsCheck.dart';
import '../../../ApiService/CouponsService/CouponsUsageApi.dart';
import '../../../Color&Icons/color.dart';
import '../../../provider/Coupons_Provider.dart';
import '../../../provider/SelectionMarkColor_Provider.dart';


class CouponsCardDetails extends StatefulWidget {
  const CouponsCardDetails({Key? key}) : super(key: key);

  @override
  _CouponsCardDetailsState createState() => _CouponsCardDetailsState();
}

class _CouponsCardDetailsState extends State<CouponsCardDetails> {
  late Future<Map<int, int>> _couponUsageMap;
  late Future<Map<int, String>> _couponStatusMap;

  @override
  void initState() {
    super.initState();
    _couponUsageMap = _fetchAllCouponUsage();
    _couponStatusMap = _fetchAllCouponStatus();
  }

  Future<Map<int, int>> _fetchAllCouponUsage() async {
    CouponsProvider couponsProvider = Provider.of<CouponsProvider>(context, listen: false);
    var couponList = couponsProvider.couponsMark;
    Map<int, int> usageMap = {};

    for (var coupon in couponList) {
      int usage = await fetchCouponUsage(coupon.couponNo);
      usageMap[coupon.couponNo] = usage;
    }

    return usageMap;
  }

  Future<Map<int, String>> _fetchAllCouponStatus() async {
    CouponsProvider couponsProvider = Provider.of<CouponsProvider>(context, listen: false);
    var couponList = couponsProvider.couponsMark;
    Map<int, String> statusMap = {};

    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);

    for (var coupon in couponList) {
      String status = await checkCouponStatus(auth.userId, coupon.couponNo);
      statusMap[coupon.couponNo] = status;
    }

    return statusMap;
  }

  @override
  Widget build(BuildContext context) {
    CouponsProvider couponsProvider = Provider.of<CouponsProvider>(context, listen: true);
    var couponList = couponsProvider.couponsMark;
    MarkColorProvider markProvider = Provider.of<MarkColorProvider>(context, listen: true);
    var markDetails = markProvider.oneMarkByIDCoupons;
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);

    List<Widget> rows = [];

    DateTime now = DateTime.now();
    var validCoupons = couponList.where((coupon) => coupon.expiryDate.isAfter(now)).toList();

    if (validCoupons.isEmpty || couponList.isEmpty) {
      rows.add(
        Padding(
          padding: const EdgeInsets.all(8.0).w,
          child: Center(
            child: Text(
              'No coupons added yet.',
              style: TextStyle(
                fontSize: 12.sp,
                color: tdGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else {
      return FutureBuilder<Map<int, int>>(
        future: _couponUsageMap,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: tdBlack,));
          } else if (snapshot.hasError) {
            return Center(child: Text('something went wrong. check your connection',style: TextStyle(fontSize: 12.sp,color: tdGrey,fontWeight: FontWeight.bold),));
          } else if (snapshot.hasData) {
            var usageMap = snapshot.data!;
            return FutureBuilder<Map<int, String>>(
              future: _couponStatusMap,
              builder: (context, statusSnapshot) {
                if (statusSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: tdBlack,));
                } else if (statusSnapshot.hasError) {
                  return Center(child: Text('something went wrong. check your connection',style: TextStyle(fontSize: 12.sp,color: tdGrey,fontWeight: FontWeight.bold),));
                } else if (statusSnapshot.hasData) {
                  var statusMap = statusSnapshot.data!;
                  for (var coupon in couponList) {
                    DateTime expiryDate = coupon.expiryDate;
                    if (expiryDate.isBefore(now)) {
                      continue;
                    }

                    int daysLeft = expiryDate.difference(now).inDays;
                    int usageCount = usageMap[coupon.couponNo] ?? 0;
                    String couponStatus = statusMap[coupon.couponNo] ?? 'Unknown';

                    rows.add(
                      Padding(
                        padding: const EdgeInsets.all(4).w,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5).w,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(-16214415)),
                                  borderRadius: BorderRadius.circular(5.w),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5).w,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 2.sp,
                                      ),
                                      Text(
                                        '${coupon.savings} %',
                                        style: TextStyle(
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(-16214415),
                                        ),
                                      ),
                                      Text(
                                        'OFF',
                                        style: TextStyle(
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(-16214415),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.sp,
                                      ),
                                      Container(
                                        width: 35.w,
                                        color: const Color(-16214415),
                                        child: Center(
                                          child: Text(
                                            'Deal',
                                            style: TextStyle(
                                              color: tdWhite,
                                              fontSize: 8.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.sp,
                            ),
                            SizedBox(
                              width: 180.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8).w,
                                    child: Text(
                                      '${markDetails[0].markName ?? ""} Member Offer: Up to ${coupon.savings}% off for Member Only ',
                                      style: TextStyle(
                                        fontSize: 8.sp,
                                        fontWeight: FontWeight.bold,
                                        color: tdBlack,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                    children: [
                                      Container(
                                        width: 80.w,
                                        color: tdGold,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5, bottom: 2, top: 2)
                                              .w,
                                          child: Center(
                                            child: Text(
                                              '${markDetails[0].markName ?? ""} MEMBER',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: tdWhite,
                                                fontSize: 8.sp,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        'Expires in $daysLeft days',
                                        style: TextStyle(
                                          fontSize: 8.sp,
                                          color: tdGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  ReadMoreText(
                                    coupon.couponDesc,
                                    trimMode: TrimMode.Length,
                                    trimLength: 62,
                                    style: TextStyle(fontSize: 8.sp, color: tdGrey),
                                    colorClickableText: tdBlue,
                                    trimCollapsedText: 'More',
                                    trimExpandedText: 'Less',
                                    moreStyle: TextStyle(
                                      fontSize: 8.sp,
                                      color: tdBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    lessStyle: TextStyle(
                                      fontSize: 8.sp,
                                      color: tdBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (couponStatus == 'Show Coupon') {
                                        context.push(context.namedLocation('CouponsPromotion',
                                            pathParameters: {
                                              'couponsId': coupon.couponNo.toString(),
                                            }));
                                      } else if (couponStatus == 'Get Coupon') {
                                        _getCoupons(context, auth.userId, coupon.couponNo,coupon.validFor,coupon.code,coupon.minOrderValue,coupon.savings).then((_) {
                                          setState(() {
                                            _couponStatusMap = _fetchAllCouponStatus();
                                          });
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      color: const Color(-9305855),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0).w,
                                        child: Center(
                                          child: Text(
                                            couponStatus,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: tdWhite,
                                              fontSize: 8.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.wifi,
                                            size: 10.w,
                                            color: tdGrey,
                                          ),
                                          Text(
                                            ' $usageCount People Used',
                                            style: TextStyle(
                                              fontSize: 8.sp,
                                              color: tdGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.email,
                                            size: 10.w,
                                            color: tdGrey,
                                          ),
                                          Text(
                                            'Email',
                                            style: TextStyle(
                                              color: tdBlue,
                                              fontSize: 8.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.share,
                                            size: 10.w,
                                            color: tdGrey,
                                          ),
                                          Text(
                                            'Share',
                                            style: TextStyle(
                                              color: tdBlue,
                                              fontSize: 8.sp,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: rows,
                  );
                } else {
                  return Container();
                }
              },
            );
          } else {
            return Container();
          }
        },
      );
    }
    return Column(
      children: rows,
    );
  }



  Future<void> _getCoupons(BuildContext context, int userId, int couponNo,String validFor,String code,String minOrder,String saving) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: tdWhite,
          surfaceTintColor: tdWhite,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Get Coupon',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Do you want to get this coupon?',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if(userId == 0){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: tdBlack,
                            duration: const Duration(seconds: 2),
                            content: Text(
                              'Login please to get this coupon',
                              style: TextStyle(fontSize: 10.sp, color: tdWhite),
                            ),
                          ),
                        );
                        Navigator.of(context).pop();
                        return;
                      }
                      bool success = await getCoupons(userNo: userId, used: 0, couponNo: couponNo,validFor: validFor,code: code,savings: saving,minOrderValue: minOrder );
                      if (success) {
                        Navigator.of(context).pop();
                        setState(() {});
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: tdBlack,
                            duration: const Duration(seconds: 1),
                            content: Text(
                              'Something went wrong. Check your connection',
                              style: TextStyle(fontSize: 10.sp, color: tdWhite),
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 100.w,
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'YES',
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: tdBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 100.w,
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: tdBlack,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'NO',
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }


}




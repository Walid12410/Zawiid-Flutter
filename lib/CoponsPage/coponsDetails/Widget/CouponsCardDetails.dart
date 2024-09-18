import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/ApiService/CouponsService/GetCouponsApi.dart';
import 'package:zawiid/EmailService/EmailShareCoupons.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import '../../../ApiService/CouponsService/CouponsCheck.dart';
import '../../../ApiService/CouponsService/CouponsUsageApi.dart';
import '../../../Color&Icons/color.dart';
import '../../../provider/Coupons_Provider.dart';
import '../../../provider/SelectionMarkColor_Provider.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:intl/intl.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}


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
    CouponsProvider couponsProvider =
        Provider.of<CouponsProvider>(context, listen: false);
    var couponList = couponsProvider.couponsMark;
    Map<int, int> usageMap = {};

    for (var coupon in couponList) {
      int usage = await fetchCouponUsage(coupon.couponNo);
      usageMap[coupon.couponNo] = usage;
    }

    return usageMap;
  }

  Future<Map<int, String>> _fetchAllCouponStatus() async {
    CouponsProvider couponsProvider =
        Provider.of<CouponsProvider>(context, listen: false);
    var couponList = couponsProvider.couponsMark;
    Map<int, String> statusMap = {};

    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);

    for (var coupon in couponList) {
      String status = await checkCouponStatus(auth.userId, coupon.couponNo);
      statusMap[coupon.couponNo] = status;
    }

    return statusMap;
  }


  bool _isSharing = false;

  Future<void> _shareCoupon(String title) async {

    final message = 'Check out this coupon!\n$title\nzawiid: ${ApiEndpoints.shareCouponsLink}';

    if (!_isSharing) {
      setState(() {
        _isSharing = true;
      });

      await Share.share(message);

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isSharing = false;
        });
      });
    }
  }

  bool _isSending = false;

  Future<void> _sendEmail(String subject, String body) async {
    if (!_isSending) {
      setState(() {
        _isSending = true;
      });

      try {
        await sendEmail(subject, body);

        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            _isSending = false;
          });
        });
      } catch (e) {
        setState(() {
          _isSending = false;
        });
       throw Exception(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    CouponsProvider couponsProvider = Provider.of<CouponsProvider>(context, listen: true);
    MarkColorProvider markProvider = Provider.of<MarkColorProvider>(context, listen: true);
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);

    var couponList = couponsProvider.couponsMark;
    var markDetails = markProvider.oneMarkByIDCoupons;

    List<Widget> rows = [];

    DateTime now = DateTime.now();
    var validCoupons =
        couponList.where((coupon) => coupon.expiryDate.isAfter(now)).toList();

    if (validCoupons.isEmpty || couponList.isEmpty) {
      rows.add(
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
      );
    } else {
      return FutureBuilder<Map<int, int>>(
        future: _couponUsageMap,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: tdBlack,
            ));
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
             S.of(context).errorConnection,
              style: TextStyle(
                  fontSize: 12.sp, color: tdGrey, fontWeight: FontWeight.bold),
            ));
          } else if (snapshot.hasData) {
            var usageMap = snapshot.data!;
            return FutureBuilder<Map<int, String>>(
              future: _couponStatusMap,
              builder: (context, statusSnapshot) {
                if (statusSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: tdBlack,
                  ));
                } else if (statusSnapshot.hasError) {
                  return Center(
                      child: Text(
                    S.of(context).errorConnection,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: tdGrey,
                        fontWeight: FontWeight.bold),
                  ));
                } else if (statusSnapshot.hasData) {
                  var statusMap = statusSnapshot.data!;
                  for (var coupon in couponList) {
                    DateTime expiryDate = coupon.expiryDate;
                    if (expiryDate.isBefore(now)) {
                      continue;
                    }

                    int daysLeft = expiryDate.difference(now).inDays;
                    int usageCount = usageMap[coupon.couponNo] ?? 0;
                    String couponStatus =
                        statusMap[coupon.couponNo] ?? 'Unknown';

                    rows.add(
                      Padding(
                        padding: const EdgeInsets.all(4).w,
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5, bottom: 5).w,
                              child: Container(
                                width: 40.w,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: const Color(-16214415)),
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
                                        width: double.infinity,
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
                                                  left: 5,
                                                  right: 5,
                                                  bottom: 2,
                                                  top: 2)
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
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8).w,
                                    child: ReadMoreText(
                                      coupon.couponDesc,
                                      trimMode: TrimMode.Length,
                                      trimLength: 62,
                                      style: TextStyle(
                                          fontSize: 8.sp, color: tdGrey),
                                      colorClickableText: tdBlue,
                                      trimCollapsedText: S.of(context).more,
                                      trimExpandedText: S.of(context).less,
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
                                        context.push(context.namedLocation(
                                            'CouponsPromotion',
                                            pathParameters: {
                                              'couponsId':
                                                  coupon.couponNo.toString(),
                                            }));
                                      } else if (couponStatus == 'Get Coupon') {
                                        _getCoupons(
                                                context,
                                                auth.userId,
                                                coupon.couponNo,
                                                coupon.validFor,
                                                coupon.code,
                                                coupon.minOrderValue,
                                                coupon.savings,
                                                coupon.expiryDate.toString())
                                            .then((_) {
                                              setState(() {
                                                _couponStatusMap =
                                                    _fetchAllCouponStatus();
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.wifi,
                                            size: 10.w,
                                            color: tdGrey,
                                          ),
                                          Text(
                                            ' $usageCount ${S.of(context).peopleUsed}',
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              _sendEmail('Check out this coupons', '${coupon.couponDesc.toString()}\n discount: ${coupon.savings}%');
                                            },
                                            child: Icon(
                                              Icons.email,
                                              size: 10.w,
                                              color: tdGrey,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              _sendEmail('Check out this coupons', '${coupon.couponDesc.toString()}\n discount: ${coupon.savings}%');
                                            },
                                            child: Text(
                                              S.of(context).email,
                                              style: TextStyle(
                                                color: tdBlue,
                                                fontSize: 8.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap:(){
                                              _shareCoupon("${coupon.couponDesc}\ndiscount: ${coupon.savings}%");
                                            },
                                            child: Icon(
                                              Icons.share,
                                              size: 10.w,
                                              color: tdGrey,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              _shareCoupon("${coupon.couponDesc}\ndiscount: ${coupon.savings}%");
                                            },
                                            child: Text(
                                              S.of(context).share,
                                              style: TextStyle(
                                                color: tdBlue,
                                                fontSize: 8.sp,
                                              ),
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

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 10.sp, color: tdWhite),
        ),
        backgroundColor: tdBlack,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _getCoupons(
      BuildContext context,
      int userId,
      int couponNo,
      String validFor,
      String code,
      String minOrder,
      String saving,
      String expiryDate) async {
    bool isConfirming = false;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return Future.value(false);
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            backgroundColor: tdWhite,
            surfaceTintColor: tdWhite,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.of(context).getCoupon,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  S.of(context).doYouWantToGetThisCoupon,
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
                        if (userId == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: tdBlack,
                              duration: const Duration(seconds: 2),
                              content: Text(
                                S.of(context).loginPleaseToGetThisCoupon,
                                style: TextStyle(fontSize: 10.sp, color: tdWhite),
                              ),
                            ),
                          );
                          Navigator.of(context).pop();
                          return;
                        }
                        if (isConfirming) return;
                        isConfirming = true;
                        try {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: tdBlack,
                                ),
                              );
                            },
                          );
                          bool success = await getCoupons(
                              userNo: userId,
                              expiryDate: expiryDate,
                              used: 0,
                              couponNo: couponNo,
                              validFor: validFor,
                              code: code,
                              savings: saving,
                              minOrderValue: minOrder);
                          if (!success) {
                            setState(() {
                              _showErrorSnackBar(S.of(context).errorConnection);
                            });
                          }
                        } catch (e) {
                          setState(() {
                            isConfirming = false;
                            Navigator.of(context).pop();
                            _showErrorSnackBar(
                                S.of(context).errorConnection);
                          });
                        } finally {
                          setState(() {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            isConfirming = false;
                          });
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
                            S.of(context).yes,
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
                            S.of(context).no,
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
          ),
        );
      },
    );
  }
}

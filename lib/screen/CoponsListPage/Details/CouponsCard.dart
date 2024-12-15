import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:readmore/readmore.dart";
import "package:share_plus/share_plus.dart";
import "package:zawiid/Api/CouponsService.dart";
import "package:zawiid/Api/EmailService.dart";
import "package:zawiid/core/Color&Icons/color.dart";
import "package:zawiid/core/config.dart";
import "package:zawiid/generated/l10n.dart";
import "package:zawiid/model/Coupons/Coupon.dart";
import "package:zawiid/model/Coupons/TotalGetCoupons.dart";
import "package:zawiid/provider/Auth_Provider.dart";
import "package:zawiid/provider/Coupons_Provider.dart";
import "package:zawiid/provider/SelectionMarkColor_Provider.dart";

class CouponCard extends StatefulWidget {
  const CouponCard({super.key, required this.coupon});

  final Coupon coupon;

  @override
  State<CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard> {
  bool _isSending = false;
  bool _isSharing = false;

  Future<void> _shareCoupon(String title) async {
    final message =
        'Check out this coupon!\n$title\nzawiid: ${ApiEndpoints.shareCouponsLink}';
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

  Future<void> _sendEmail(String subject, String body) async {
    EmailService service = EmailService();
    if (!_isSending) {
      setState(() {
        _isSending = true;
      });
      try {
        await service.sendEmail(subject, body);
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
    final markProvider = Provider.of<MarkColorProvider>(context, listen: true);
    final couponsProvider = Provider.of<CouponsProvider>(context, listen: true);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    var mark = markProvider.oneMarkByIDCoupons.first;
    var totalGetPromo = couponsProvider.totalGetCoupon;
    var userCoupons = couponsProvider.userCoupons;
    var userId = authProvider.userId;

    // Get the totalGetCoupons for the given couponId, or return 0 if not found
    int totalCoupons = totalGetPromo
        .firstWhere((promo) => promo.couponNo == widget.coupon.couponNo,
            orElse: () => TotalGetCoupons(
                couponNo: widget.coupon.couponNo,
                totalGetCoupons: 0) // Default value
            )
    .totalGetCoupons;



    DateTime now = DateTime.now();
    DateTime expiryDate = widget.coupon.expiryDate;
    int daysLeft = expiryDate.difference(now).inDays;

    bool hasPromo = userCoupons.any((promo) => promo.couponNo == widget.coupon.couponNo);
    bool hasUsedPromo = false;

    if (hasPromo) {
      final promo = userCoupons.firstWhere((promo) => promo.couponNo == widget.coupon.couponNo);
      if(promo.used == 1){
       hasUsedPromo = true;
      }else{
        hasUsedPromo = false;
      }
    }


    return Padding(
      padding: const EdgeInsets.all(4).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5).w,
            child: Container(
              width: 40.w,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(-16214415)),
                borderRadius: BorderRadius.circular(5.w),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 5).w,
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      '${widget.coupon.savings} %',
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
                    '${mark.markName} Offer: Up to ${widget.coupon.savings}% off',
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
                            mark.markName,
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
                    widget.coupon.couponDesc,
                    trimMode: TrimMode.Length,
                    trimLength: 62,
                    style: TextStyle(fontSize: 8.sp, color: tdGrey),
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
                if(!hasPromo || hasUsedPromo)...[
                GestureDetector(
                  onTap: () {
                    if(hasUsedPromo) {
                      return;
                    }else{
                      _getCoupons(context, widget.coupon, userId);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    color: const Color(-9305855),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0).w,
                      child: Center(
                        child: Text(
                          hasUsedPromo ? 'USED' : 'GET COUPON',
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
                ] else...[
                GestureDetector(
                  onTap: () {
                      context.push(context.namedLocation(
                          'CouponsPromotion',
                          pathParameters: {
                            'couponsId':
                                widget.coupon.couponNo.toString(),
                          }));
                  },
                  child: Container(
                    width: double.infinity,
                    color: const Color(-9305855),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0).w,
                      child: Center(
                        child: Text(
                          'SHOW COUPON',
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
                ],
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
                          '$totalCoupons ${S.of(context).peopleUsed}',
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
                        GestureDetector(
                          onTap: () {
                            _sendEmail('Check out this coupons',
                                '${widget.coupon.couponDesc.toString()}\n discount: ${widget.coupon.savings}%');
                          },
                          child: Icon(
                            Icons.email,
                            size: 10.w,
                            color: tdGrey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _sendEmail('Check out this coupons',
                                '${widget.coupon.couponDesc.toString()}\n discount: ${widget.coupon.savings}%');
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
                          onTap: () {
                            _shareCoupon(
                                "${widget.coupon.couponDesc}\ndiscount: ${widget.coupon.savings}%");
                          },
                          child: Icon(
                            Icons.share,
                            size: 10.w,
                            color: tdGrey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _shareCoupon(
                                "${widget.coupon.couponDesc}\ndiscount: ${widget.coupon.savings}%");
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
    );
  }

    Future<void> _getCoupons(
      BuildContext context,
      Coupon coupon , int userId) async {
    bool isConfirming = false;
    final couponsProvider = Provider.of<CouponsProvider>(context, listen: false);

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
                        CouponsService service = CouponsService();

                        if (userId == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: tdBlack,
                              duration: const Duration(seconds: 2),
                              content: Text(
                                S.of(context).loginPleaseToGetThisCoupon,
                                style:
                                    TextStyle(fontSize: 10.sp, color: tdWhite),
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
                          bool success = await service.getCoupons(
                              userNo: userId,
                              expiryDate: coupon.expiryDate.toString(),
                              used: 0,
                              couponNo: coupon.couponNo,
                              validFor: coupon.validFor,
                              code: coupon.code,
                              savings: coupon.savings,
                              minOrderValue: coupon.minOrderValue);
                          if (!success) {
                            setState(() {
                              _showErrorSnackBar(S.of(context).errorConnection);
                            });
                          }
                          await couponsProvider.getUserCoupons(userId);
                        } catch (e) {
                          setState(() {
                            isConfirming = false;
                            Navigator.of(context).pop();
                            _showErrorSnackBar(S.of(context).errorConnection);
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

}

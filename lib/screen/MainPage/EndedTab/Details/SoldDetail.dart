import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/core/config.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/model/Bid/bidProduct.dart';

class SolidCard extends StatefulWidget {
  const SolidCard({
    Key? key,
    required this.endedBid
  }) : super(key: key);

  final BidProduct endedBid;

  @override
  _SolidCardState createState() => _SolidCardState();
}

class _SolidCardState extends State<SolidCard> {

  @override
  Widget build(BuildContext context) {
    String formattedStartTime = DateFormat('d MMMM, hh:mm a').format(widget.endedBid.bidEndDate);

    return Padding(
      padding: const EdgeInsets.all(8.0).w,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20).w,
            child: SizedBox(
              width: double.infinity,
              height: 210.h,
              child: CachedNetworkImage(
                imageUrl: '${ApiEndpoints.localBaseUrl}/${widget.endedBid.productImage}',
                placeholder: (context, url) =>
                    Image.asset('assets/log/LOGO-icon---Black.png'),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/log/LOGO-icon---Black.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            '${widget.endedBid.productName} / ${widget.endedBid.colorName}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              color: tdBlack,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5.h),
          Text(
            formattedStartTime,
            style: TextStyle(fontSize: 8.sp, color: tdGrey),
          ),
          SizedBox(height: 2.h),
           Text(
            '${S.of(context).soldAt} ${widget.endedBid.soldAtPrice}\$',
            style: TextStyle(fontSize: 8.sp, color: tdGrey),
          ),
          SizedBox(height: 10.h),
          Container(
            width: 180.w,
            height: 20.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20).w,
              border: Border.all(color: tdBlack),
            ),
            child: Center(
              child: Text(S.of(context).sold,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: tdBlack,
                ),
              ),
            ),
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}

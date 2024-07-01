import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TicketImage extends StatelessWidget {
  const TicketImage({
    super.key,
    required this.ticketImage,
  });

  final String ticketImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.w),
      child: Container(
        width: double.infinity,
        height: 300.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.w),
          image: DecorationImage(
            image: CachedNetworkImageProvider(ticketImage),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

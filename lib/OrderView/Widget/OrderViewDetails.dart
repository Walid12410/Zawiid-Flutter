import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../ApiEndPoint.dart';
import '../../Color&Icons/color.dart';
import '../../provider/OrderProvider.dart';

class OrderViewDetails extends StatelessWidget {
  const OrderViewDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: true);
    var orders = orderProvider.orderUser;

    return Column(
      children: [
        if (orders.isEmpty)
          Column(
            children: [
              SizedBox(height: 100.h,),
              Text(
                'no order added yet',
                style: TextStyle(fontSize: 12.sp, color: tdGrey,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          )
        else
          Column(
            children: [
              for (var order in orderProvider.orderUser)
                  Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10.w, left: 2.w),
                            child: SizedBox(
                              width: 70.w,
                              height: 90.h,
                              child: CachedNetworkImage(
                                imageUrl:
                                '${ApiEndpoints.localBaseUrl}/${order.productImage}',
                                placeholder: (context, url) => Image.asset(
                                    'assets/log/LOGO-icon---Black.png'),
                                errorWidget: (context, url, error) => Image.asset(
                                    'assets/log/LOGO-icon---Black.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.productName,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: tdBlack,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 170.w),
                                  child: Text(
                                    order.productDesc,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Text('QTY: ${order.productQty}',style: TextStyle(fontSize: 8.sp,color: tdBlack,fontWeight: FontWeight.bold),),
                                SizedBox(height: 15.h),
                                Text(
                                  '\$${double.parse(order.productPrice) * order.productQty}', // Assuming productPrice is a double
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: tdGrey,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  'SKU: FT00962',
                                  style: TextStyle(fontSize: 4.sp, color: tdGrey),
                                ),
                              ],
                            ),

                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
            ],
          ),
      ],
    );
  }
}

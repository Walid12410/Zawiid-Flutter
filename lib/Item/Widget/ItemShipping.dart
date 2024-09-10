import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Color&Icons/color.dart';
import '../../provider/Delivery_Provider.dart';
import 'package:intl/intl.dart';
import 'package:zawiid/generated/l10n.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}


class ItemShipping extends StatelessWidget {
  const ItemShipping({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final deliveryProvider = Provider.of<DeliveryProvider>(context, listen: true);
    var deliveryOptions = deliveryProvider.allDeliveryOpt;

    if (deliveryOptions.isEmpty) {
      return const SizedBox();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).shipping,
          style: TextStyle(
              fontSize: 17.sp, fontWeight: FontWeight.bold, color: tdBlack),
        ),
        for (var option in deliveryOptions)
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                     Text(
                        option.optionName,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: tdBlack,
                        ),
                        overflow: TextOverflow.ellipsis, // Ensure long text does not overflow
                      ),
                    if (option.additionalCost.isNotEmpty &&
                        double.tryParse(option.additionalCost) != null &&
                        double.parse(option.additionalCost) > 0)
                      Text(
                        ' (${option.additionalCost}\$)',
                        style: TextStyle(fontSize: 7.sp, color: tdGrey),
                        overflow: TextOverflow.ellipsis, // Ensure long text does not overflow
                      )
                    else
                      Text(
                        ' (Free)',
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: tdBlack,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis, // Ensure long text does not overflow
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  option.description,
                  style: TextStyle(fontSize: 12.sp, color: tdBlack),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

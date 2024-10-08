import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/provider/Cart_Provider.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

class ItemDetailsHead extends StatelessWidget {
  const ItemDetailsHead({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: true);
    var cartLength = cart.cartUser;

    return Padding(
      padding:isArabic()? const EdgeInsets.only(left: 15, right: 12, top: 15).w:
      const EdgeInsets.only(right: 15, left: 12, top: 15).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: SizedBox(
              width: 20.w,
              height: 18.h,
              child: Image.asset('assets/img/pop.png', fit: BoxFit.contain),
            ),
          ),
          GestureDetector(
            onTap: () {
              context.push(context.namedLocation('CartPage'));
            },
            child: badges.Badge(
              badgeContent: Text(
                '${cartLength.length}',
                style: TextStyle(color: tdWhite, fontSize: 10.sp),
              ),
              badgeStyle: const badges.BadgeStyle(badgeColor: tdBlack),
              position: isArabic()
                  ? badges.BadgePosition.custom(bottom: -7, start: -5)
                  : badges.BadgePosition.custom(bottom: -7, end: -5),
              child: Image.asset(
                'assets/svg/cart.png',
                width: 25.w,
                fit: BoxFit.fill,
                color: tdBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

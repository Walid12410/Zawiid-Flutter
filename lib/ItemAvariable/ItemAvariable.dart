import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:badges/badges.dart' as badges;

class ItemDetails {
  final String title;
  final String desc;
  final double mainPrice;
  final double salePrice;

  ItemDetails({
    required this.title,
    required this.desc,
    required this.mainPrice,
    required this.salePrice,
  });
}

final List<ItemDetails> items = [
  ItemDetails(
    title: 'iPhone 12',
    desc: 'Latest Apple iPhone',
    mainPrice: 999.99,
    salePrice: 899.99,
  ),
  ItemDetails(
    title: 'Samsung Galaxy S21',
    desc: 'Latest Samsung Galaxy',
    mainPrice: 899.99,
    salePrice: 799.99,
  ),
  ItemDetails(
    title: 'APPLE',
    desc: 'Apple iPhone 15 Pro Max 6.7- Inch 250GB White Titanium',
    mainPrice: 899.99,
    salePrice: 799.99,
  ),
  ItemDetails(
    title: 'Samsung Galaxy S21',
    desc: 'Latest Samsung Galaxy',
    mainPrice: 899.99,
    salePrice: 799.99,
  ),
  ItemDetails(
    title: 'APPLE',
    desc: 'Apple iPhone 15 Pro Max 6.7- Inch 250GB White Titanium',
    mainPrice: 899.99,
    salePrice: 799.99,
  ),

  // Add more items as needed
];

class ItemViewCategories extends StatefulWidget {
  const ItemViewCategories({super.key});

  @override
  State<ItemViewCategories> createState() => _ItemViewCategoriesState();
}

class _ItemViewCategoriesState extends State<ItemViewCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ItemCategoriesHead(),
              SizedBox(
                height: 5.h,
              ),
              const ItemSearchBar(),
              SizedBox(
                height: 10.h,
              ),
              for (int i = 0; i < items.length; i += 2)
                Padding(
                  padding: const EdgeInsets.all(2).w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5).w,
                        child: CartItemView(
                          title: items[i].title,
                          desc: items[i].desc,
                          mainPrice: items[i].mainPrice,
                          salePrice: items[i].salePrice,
                        ),
                      ),
                      if (i + 1 < items.length)
                        Padding(
                          padding: const EdgeInsets.all(5).w,
                          child: CartItemView(
                            title: items[i + 1].title,
                            desc: items[i + 1].desc,
                            mainPrice: items[i + 1].mainPrice,
                            salePrice: items[i + 1].salePrice,
                          ),
                        ),
                    ],
                  ),
                ),
              SizedBox(height: 5.h)
            ],
          ),
        ),
      ),
    );
  }
}

class CartItemView extends StatelessWidget {
  const CartItemView(
      {super.key,
      required this.title,
      required this.desc,
      required this.mainPrice,
      required this.salePrice});

  final String title;
  final String desc;
  final double mainPrice;
  final double salePrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      height: 230.h,
      decoration: BoxDecoration(
        color: tdWhite,
        borderRadius: BorderRadius.circular(10).w,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 90.w,
              height: 100.h,
              child: Image.asset(
                'assets/img/iphone.png',
                fit: BoxFit.fill,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20).w,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 12.sp, color: tdBlack, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15).w,
            child: Text(
              desc,
              style: TextStyle(
                fontSize: 8.sp,
                color: tdBlack,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            '$salePrice KD',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Colors.red),
          ),
          Text(
            '$mainPrice kD',
            style: TextStyle(
              fontSize: 10.sp, color: tdBlack,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.lineThrough,
              decorationThickness:
                  2.5, // Adjust the thickness of the line through
              decorationColor: tdGrey,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10).w,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 25.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: tdBlack, borderRadius: BorderRadius.circular(5).w),
                child: Center(
                  child: Text(
                    'Add to cart',
                    style: TextStyle(fontSize: 8.sp, color: tdWhite),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5.h)
        ],
      ),
    );
  }
}

class ItemSearchBar extends StatelessWidget {
  const ItemSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 8).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              context.push(context.namedLocation('NotificationPage'));
            },
            child: badges.Badge(
              badgeContent: Text(
                '8',
                style: TextStyle(color: tdWhite, fontSize: 10.sp),
              ),
              badgeStyle: const badges.BadgeStyle(badgeColor: tdBlack),
              position: badges.BadgePosition.custom(bottom: -7,end: -5),
              child: Image.asset(
                'assets/svg/notification.png',
                width:  25.w,
                height: 22.h,
                fit: BoxFit.fill,
                color: tdBlack,
              ),
            ),
          ),
          SizedBox(width: 1.w),
          Container(
            height: 30.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(50).w,
            ),
            child: Row(
              children: [
                Container(
                  width: 233.w,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ).w,
                  ),
                  child: Center(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for products',
                        hintStyle: TextStyle(fontSize: 9.sp, color: tdGrey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                        isDense:
                            true, // To reduce the inner padding of the TextField
                      ),
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                ),
                Container(
                  width: 35.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                      color: tdBlack,
                      borderRadius: BorderRadius.only(
                          topRight: const Radius.circular(20).w,
                          bottomRight: const Radius.circular(20).w)),
                  child: Center(
                    child: Icon(Icons.search, color: tdWhite, size: 20.w),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              context.push(context.namedLocation('CartPage'));
            },
            child: badges.Badge(
              badgeContent: Text(
                '3',
                style: TextStyle(color: tdWhite, fontSize: 8.sp),
              ),
              badgeStyle: const badges.BadgeStyle(badgeColor: tdBlack),
              position: badges.BadgePosition.custom(bottom: -7,end: -5),
              child: Image.asset(
                'assets/svg/cart.png',
                width:  25.w,
                height: 22.h,
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

class ItemCategoriesHead extends StatelessWidget {
  const ItemCategoriesHead({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20).w,
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
              child: Image.asset('assets/img/pop2.png', fit: BoxFit.contain),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10).w,
            child: Text('Accessories',
                style: TextStyle(
                    color: tdBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp)),
          ),
          SizedBox(
            width: 20.w,
          )
        ],
      ),
    );
  }
}

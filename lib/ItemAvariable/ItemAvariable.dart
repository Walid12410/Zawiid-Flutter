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




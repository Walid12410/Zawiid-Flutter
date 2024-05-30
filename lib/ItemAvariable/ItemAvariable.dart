import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:badges/badges.dart' as badges;

import 'Widget/CartItemView.dart';
import 'Widget/ItemViewHead.dart';
import 'Widget/ItemViewSearchBar.dart';

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
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filter the items based on the search query
    List<ItemDetails> filteredItems = items
        .where((item) =>
    item.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
        item.desc.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

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
              ItemSearchBar(
                controller: searchController,
                onSearch: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              for (int i = 0; i < filteredItems.length; i += 2)
                Padding(
                  padding: const EdgeInsets.all(2).w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5).w,
                        child: CartItemView(
                          title: filteredItems[i].title,
                          desc: filteredItems[i].desc,
                          mainPrice: filteredItems[i].mainPrice,
                          salePrice: filteredItems[i].salePrice,
                        ),
                      ),
                      if (i + 1 < filteredItems.length)
                        Padding(
                          padding: const EdgeInsets.all(5).w,
                          child: CartItemView(
                            title: filteredItems[i + 1].title,
                            desc: filteredItems[i + 1].desc,
                            mainPrice: filteredItems[i + 1].mainPrice,
                            salePrice: filteredItems[i + 1].salePrice,
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

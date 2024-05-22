import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zawiid/Color&Icons/color.dart';

class TitleCategory {
  final String title;
  final List<String> categories;

  TitleCategory(this.title, this.categories);
}

class DrawerWithDropdown extends StatefulWidget {
  @override
  _DrawerWithDropdownState createState() => _DrawerWithDropdownState();
}

class _DrawerWithDropdownState extends State<DrawerWithDropdown> {
  List<TitleCategory> titleCategories = [
    TitleCategory('OpenBox', ['Mobile & Accessories', 'Tablet','Laptop','Iphone','Samsung']),
    TitleCategory('Kashe', ['Mobile', 'Tablet']),
    TitleCategory('Dell', ['Laptop', 'Board','Cpu','Ram','GPU']),
    TitleCategory('Deldsl', ['h']),
  ];

  Map<String, bool> isExpandedMap = {};

  @override
  void initState() {
    super.initState();
    for (var category in titleCategories) {
      isExpandedMap[category.title] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: tdWhite,
      backgroundColor: tdWhite,
      width: 270.w,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero
      ),

      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 70).w,
              child: Container(
                width: double.infinity,
                height: 25.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20).w,
                  color: tdWhite,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10).w,
                      child: Text(
                        'Search for products',
                        style: TextStyle(fontSize: 8.sp),
                      ),
                    ),
                    Container(
                      width: 35.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: const Radius.circular(20).w,
                          bottomRight: const Radius.circular(20).w,
                        ),
                        color: tdBlack,
                      ),
                      child: Center(
                        child: Icon(Icons.search, color: tdWhite, size: 20.w),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  for (var i = 0; i < titleCategories.length; i++) ...[
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey.shade300),
                          bottom: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: ListTileTheme(
                        data: ListTileThemeData(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          horizontalTitleGap: 0.0,
                          minLeadingWidth: 0,
                          dense: true,
                        ),
                        child: ExpansionTile(
                          tilePadding:
                          const EdgeInsets.only(left: 15, right: 10).w,
                          collapsedShape: const RoundedRectangleBorder(
                            side: BorderSide.none,
                          ),
                          shape: const RoundedRectangleBorder(
                            side: BorderSide.none,
                          ),
                          title: Text(
                            titleCategories[i].title,
                            style: TextStyle(fontSize: 13.sp, color: tdBlack),
                          ),
                          trailing: isExpandedMap[titleCategories[i].title] != null
                              ? SizedBox(
                            width: 20.w,
                            height: 17.h,
                            child: SvgPicture.asset(
                                isExpandedMap[titleCategories[i].title]!
                                    ? 'assets/svg/arrow_down.svg'
                                    : 'assets/svg/arrow_up.svg',
                              fit: BoxFit.contain,),

                          ) : null,
                          onExpansionChanged: (isExpanded) {
                            setState(() {
                              isExpandedMap[titleCategories[i].title] = isExpanded;
                            });
                          },
                          children: [
                            for (var j = 0; j < titleCategories[i].categories.length; j++)
                              Container(
                                width: double.infinity,
                                color: tdWhiteNav,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 10)
                                      .w,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        titleCategories[i].categories[j],
                                        style: TextStyle(
                                            fontSize: 13.sp, color: tdBlack),
                                      ),
                                      if (j < titleCategories[i].categories.length - 1)
                                        const Divider(), // Add divider if it's not the last category
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

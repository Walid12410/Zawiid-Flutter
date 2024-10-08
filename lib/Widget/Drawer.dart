import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/localization/generated/l10n.dart';
import '../provider/Categories_Provider.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

class DrawerWithDropdown extends StatefulWidget {
  @override
  _DrawerWithDropdownState createState() => _DrawerWithDropdownState();
}

class _DrawerWithDropdownState extends State<DrawerWithDropdown> {
  Map<String, bool> isExpandedMap = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).getCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: true);
    var categories = categoryProvider.category;
    for (var category in categories) {
      if (!isExpandedMap.containsKey(category.categoryName)) {
        isExpandedMap[category.categoryName] = false;
      }
    }

    return Drawer(
      surfaceTintColor: tdWhite,
      backgroundColor: tdWhite,
      width: 270.w,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Padding(
              padding:isArabic()? EdgeInsets.only(right: 10.w, left: 70.w):
              EdgeInsets.only(left: 10.w, right: 70.w),
              child: GestureDetector(
                onTap: () {
                  GoRouter.of(context).goNamed('SearchPage');
                },
                child: Container(
                  width: double.infinity,
                  height: 25.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.w),
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
                        padding: isArabic()
                            ? EdgeInsets.only(right: 10.w)
                            : EdgeInsets.only(left: 10.w),
                        child: Text(
                          S.of(context).searchTitle,
                          style: TextStyle(fontSize: 8.sp),
                        ),
                      ),
                      Container(
                        width: 35.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          borderRadius: isArabic()
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(20.w),
                                  bottomLeft: Radius.circular(20.w),
                                )
                              : BorderRadius.only(
                                  topRight: Radius.circular(20.w),
                                  bottomRight: Radius.circular(20.w),
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
            ),
            SizedBox(height: 15.h),
            if (categories.isEmpty)
              Column(
                children: [
                  SizedBox(
                    height: 120.h,
                  ),
                  const Center(
                    child: CircularProgressIndicator(
                      color: tdBlack,
                    ),
                  ),
                ],
              ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  var category = categories[index];
                  return Container(
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
                        tilePadding: isArabic()
                            ? EdgeInsets.only(left: 10.w, right: 15.w)
                            : EdgeInsets.only(left: 15.w, right: 10.w),
                        collapsedShape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                        ),
                        title: Text(
                          category.categoryName,
                          style: TextStyle(fontSize: 13.sp, color: tdBlack),
                        ),
                        trailing: isExpandedMap[category.categoryName] != null
                            ? SizedBox(
                                width: 20.w,
                                height: 17.h,
                                child: SvgPicture.asset(
                                  isExpandedMap[category.categoryName]!
                                      ? 'assets/svg/arrow_down.svg'
                                      : 'assets/svg/arrow_up.svg',
                                  fit: BoxFit.contain,
                                ),
                              )
                            : null,
                        onExpansionChanged: (isExpanded) {
                          setState(() {
                            isExpandedMap[category.categoryName] = isExpanded;
                          });
                        },
                        children: [
                          if (category.subcategories != null &&
                              category.subcategories!.isNotEmpty)
                            for (var subcategory in category.subcategories!)
                              GestureDetector(
                                onTap: () {
                                  GoRouter.of(context).goNamed(
                                      'ItemViewCategories',
                                      pathParameters: {
                                        'title': subcategory.subCatName,
                                        'categoryId':
                                            subcategory.subCarNo.toString()
                                      });
                                },
                                child: Container(
                                  color: tdWhiteNav,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.w, right: 10.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          subcategory.subCatName,
                                          style: TextStyle(
                                              fontSize: 13.sp, color: tdBlack),
                                        ),
                                        if (category.subcategories!.last !=
                                            subcategory)
                                          const Divider(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          if (category.subcategories == null ||
                              category.subcategories!.isEmpty)
                            Container(
                              color: tdWhiteNav,
                              width: double.infinity,
                              child: Padding(
                                padding: isArabic()
                                    ? EdgeInsets.only(right: 15.w, left: 10.w)
                                    : EdgeInsets.only(left: 15.w, right: 10.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).noSubCategories,
                                      style: TextStyle(
                                          fontSize: 13.sp, color: tdBlack),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

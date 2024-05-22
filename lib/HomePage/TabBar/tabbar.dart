import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';

class CustomTabBarView extends StatelessWidget {
  final TabController tabController;
  final List<Widget> tabViews;

  const CustomTabBarView({
    required this.tabController,
    required this.tabViews,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          color: tdWhite,
          child: TabBar(
            controller: tabController,
            indicatorColor: tdBlack,
            isScrollable: false,
            tabs: [
              Tab(
                child: Text(
                  'Featured',
                  style:
                      TextStyle(fontSize: 15.sp, color: tdBlack),
                ),
              ),
              Tab(
                child: Text(
                  'On Sale',
                  style:
                      TextStyle(fontSize: 15.sp, color: tdBlack),
                ),
              ),
              Tab(
                child: Text('Top Rated',
                    style: TextStyle(
                        fontSize: 15.sp, color: tdBlack)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 490.h,
          child: TabBarView(
            controller: tabController,
            children: tabViews,
          ),
        ),
      ],
    );
  }
}


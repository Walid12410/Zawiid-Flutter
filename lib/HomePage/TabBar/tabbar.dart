import 'package:flutter/material.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          color: tdWhite,
          child: TabBar(
            controller: tabController,
            indicatorColor: Colors.black,
            isScrollable: false,
            tabs: [
              Tab(
                child: Text(
                  'Featured',
                  style:
                      TextStyle(fontSize: screenWidth * 0.05, color: tdBlack),
                ),
              ),
              Tab(
                child: Text(
                  'On Sale',
                  style:
                      TextStyle(fontSize: screenWidth * 0.05, color: tdBlack),
                ),
              ),
              Tab(
                child: Text('Top Rated',
                    style: TextStyle(
                        fontSize: screenWidth * 0.05, color: tdBlack)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height -
              kToolbarHeight -
              kBottomNavigationBarHeight -
              160,
          child: TabBarView(
            controller: tabController,
            children: tabViews,
          ),
        ),
      ],
    );
  }
}

double calculateTabHeight(BuildContext context) {
  final double screenHeight = MediaQuery.of(context).size.height;
  double baseHeight = 1;

  if (screenHeight > 600 && screenHeight <= 700) {
    baseHeight *= 0.88;
  } else if (screenHeight > 700 && screenHeight <= 800) {
    baseHeight *= 0.76;
  } else if (screenHeight > 800 && screenHeight <= 900) {
    baseHeight *= 0.85;
  } else if (screenHeight > 900 && screenHeight <= 1000) {
    baseHeight *= 0.72;
  } else if (screenHeight > 1000 && screenHeight <= 1100) {
    baseHeight *= 1.1;
  } else if (screenHeight > 1100 && screenHeight <= 1200) {
    baseHeight *= 1;
  } else if (screenHeight > 1200 && screenHeight <= 1300) {
    baseHeight *= 1.1;
  } else if (screenHeight > 1300 && screenHeight <= 1400) {
    baseHeight *= 1.1;
  } else if (screenHeight > 1400 && screenHeight <= 1500) {
    baseHeight *= 1.1;
  } else if (screenHeight > 1500 && screenHeight <= 1600) {
    baseHeight *= 1.1;
  } else if (screenHeight > 1600 && screenHeight <= 1700) {
    baseHeight *= 1.1;
  } else if (screenHeight > 1700 && screenHeight <= 1800) {
    baseHeight *= 1.1;
  } else if (screenHeight > 1800 && screenHeight <= 1900) {
    baseHeight *= 1.1;
  } else if (screenHeight > 1900 && screenHeight <= 2000) {
    baseHeight *= 1.1;
  } else if (screenHeight > 2000 && screenHeight <= 2100) {
    baseHeight *= 1.1;
  } else if (screenHeight > 2100 && screenHeight <= 2200) {
    baseHeight *= 1.1;
  } else if (screenHeight > 2200 && screenHeight <= 2300) {
    baseHeight *= 1.1;
  } else if (screenHeight > 2300 && screenHeight <= 2400) {
    baseHeight *= 1.1;
  } else if (screenHeight > 2400 && screenHeight <= 2500) {
    baseHeight *= 1.1;
  } else {
    baseHeight *= 1;
  }

  return baseHeight;
}

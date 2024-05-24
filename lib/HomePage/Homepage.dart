import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:zawiid/Color&Icons/color.dart';
import '../Drawer/DrawerPage.dart';
import 'TabBar/TabView/FeaturedPage.dart';
import 'TabBar/TabView/OnSalePage.dart';
import 'TabBar/TabView/TopRatedPage.dart';
import 'Widget/FeaturedProduct.dart';
import 'Widget/OpeningImage.dart';
import 'Widget/SearchBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final PageController _pageController2 = PageController(initialPage: 0);
  int _currentPage2 = 0;
  final PageController _pageController1 = PageController(initialPage: 0);
  int _currentPage1 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWithDropdown(),
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 5.h),
              Center(
                child: SizedBox(
                  width: 100.w,
                  height: 50.h,
                  child: Image.asset(
                    'assets/log/LOGO-icon---Black.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              const CustomNavigationBar(),
              SizedBox(height: 5.h),
              const OpeningImage(),
              SizedBox(height: 10.h),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FeaturedProductCard(),
                    FeaturedProductCard(),
                    FeaturedProductCard(),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _handlePageTap(0);
                            },
                            child: Text(
                              'Featured',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: _currentPage1 == 0
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: _currentPage1 == 0 ? tdBlack : tdGrey,
                              ),
                            ),
                          ),
                          Container(
                            width: 65.w,
                            height: 2.h,
                            decoration: BoxDecoration(
                              color: _currentPage1 == 0
                                  ? tdBlack
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _handlePageTap(1);
                            },
                            child: Text(
                              'On Sale',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: _currentPage1 == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: _currentPage1 == 1 ? tdBlack : tdGrey,
                              ),
                            ),
                          ),
                          Container(
                            width: 60.w,
                            height: 2.h,
                            decoration: BoxDecoration(
                              color: _currentPage1 == 1
                                  ? tdBlack
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _handlePageTap(2);
                            },
                            child: Text(
                              'Top Rated',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: _currentPage1 == 2
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: _currentPage1 == 2 ? tdBlack : tdGrey,
                              ),
                            ),
                          ),
                          Container(
                            width: 70.w,
                            height: 2.h,
                            decoration: BoxDecoration(
                              color: _currentPage1 == 2
                                  ? tdBlack
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  ExpandablePageView(
                    controller: _pageController1,
                    onPageChanged: (page) {
                      setState(() {
                        _currentPage1 = page.toInt();
                      });
                    },
                    children: const [
                      FeaturedPageView(),
                      OnSalePageView(),
                      TopRatedPageView()
                    ],
                  ),
                ],
              ),
              const SecondOpeningImage(),
              Padding(
                padding: const EdgeInsets.all(10).w,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 5,
                        offset: const Offset(0, 0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20).w,
                    color: tdWhiteNav,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0).w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 3.h),
                        Text(
                          'Week Deals Limited, Just now',
                          style: TextStyle(fontSize: 12.sp, color: tdBlack),
                        ),
                        SizedBox(height: 2.h),
                        LinearProgressBar(
                          minHeight: 2.h,
                          maxSteps: 3,
                          progressType: LinearProgressBar.progressTypeLinear,
                          currentStep: _currentPage2 + 1,
                          progressColor: tdBlack,
                          backgroundColor: tdGrey,
                        ),
                        ExpandablePageView(
                          controller: _pageController2,
                          onPageChanged: (page) {
                            setState(() {
                              _currentPage2 = page.toInt();
                            });
                          },
                          children: const [
                            WeekDealCard(
                              price: 345.00,
                              image: 'assets/img/ps4.png',
                            ),
                            WeekDealCard(
                              price: 234.00,
                              image: 'assets/img/iphone.png',
                            ),
                            WeekDealCard(
                              price: 325.00,
                              image: 'assets/img/ps4.png',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handlePageTap(int page) {
    _pageController1.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    setState(() {
      _currentPage1 = page;
    });
  }
}

class WeekDealCard extends StatelessWidget {
  const WeekDealCard({super.key, required this.price, required this.image});

  final String image;
  final double price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Center(
            child: SizedBox(
              width: 250.w,
              height: 200.h,
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$price',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                            color: tdBlack),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                        width: 25.w,
                        height: 30.h,
                        child: SvgPicture.asset(
                          'assets/svg/buy.svg',
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    width: 145.w,
                    height: 0.2.h,
                    color: tdGrey,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'SKU: FT00962',
                    style: TextStyle(fontSize: 10.sp, color: tdGrey),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Hurry Up! Offer ends in:',
                    style: TextStyle(fontSize: 12.sp, color: tdGrey),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const TimerWeekDeal(
                        name: 'HOURS',
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      const TimerWeekDeal(
                        name: 'MINS',
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      const TimerWeekDeal(
                        name: 'Secs',
                      ),
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class TimerWeekDeal extends StatelessWidget {
  const TimerWeekDeal({super.key, required this.name});

  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: tdWhite,
          border: Border.all(color: tdGrey),
          borderRadius: BorderRadius.circular(5).w),
      child: Padding(
        padding: const EdgeInsets.all(8.0).w,
        child: Column(
          children: [
            Text(
              '00',
              style: TextStyle(fontSize: 20.sp, color: tdGrey),
            ),
            Text(
              'name',
              style: TextStyle(fontSize: 7.sp, color: tdGrey),
            )
          ],
        ),
      ),
    );
  }
}

class SecondOpeningImage extends StatelessWidget {
  const SecondOpeningImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10).w,
      child: Container(
          width: double.infinity,
          height: 100.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20).w),
          child: Image.asset(
            'assets/img/sddefault.png',
            fit: BoxFit.fill,
          )),
    );
  }
}

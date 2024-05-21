import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'TabBar/TabView/FeaturedPage.dart';
import 'TabBar/TabView/OnSalePage.dart';
import 'TabBar/TabView/TopRatedPage.dart';
import 'TabBar/tabbar.dart';
import 'Widget/FeaturedProduct.dart';
import 'Widget/OpeningImage.dart';
import 'Widget/SearchBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
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
              SizedBox(height: 5.h),
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
              SizedBox(height: 10.h),

              CustomTabBarView(
                tabController: _tabController,
                tabViews: [
                  FeaturedPageView(scrollController: _scrollController),
                  OnSalePageView(scrollController: _scrollController),
                  TopRatedPageView(scrollController: _scrollController)
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10).w,
                child: Container(
                    width: double.infinity,
                    height: 90.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20).w
                    ),
                    child: Image.asset('assets/img/sddefault.png',
                    fit: BoxFit.fill,)),
              ),

            ],
          ),
        ),
      ),
    );
  }
}








import 'package:flutter/material.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: SizedBox(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.1,
                  child: Image.asset(
                    'assets/log/LOGO-icon---Black.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              CustomNavigationBar(screenWidth: screenWidth,screenHeight: screenHeight,),
              SizedBox(height: screenHeight * 0.01),
              OpeningImage(screenHeight: screenHeight),
              SizedBox(height: screenHeight * 0.01),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FeaturedProductCard(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                    ),
                    FeaturedProductCard(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                    ),
                    FeaturedProductCard(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              SizedBox(
                height: screenHeight * 0.01, // Adjust the height as needed
              ),
              CustomTabBarView(
                tabController: _tabController,
                tabViews: [
                  FeaturedPageView(scrollController: _scrollController),
                  OnSalePageView(scrollController: _scrollController),
                  TopRatedPageView(scrollController: _scrollController)
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              Padding(
                padding:  EdgeInsets.all(screenWidth * 0.02),
                child: Container(
                    width: double.infinity,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
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








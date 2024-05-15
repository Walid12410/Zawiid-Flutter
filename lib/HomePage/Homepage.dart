import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Authentication/SignIn.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:badges/badges.dart' as badges;


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
              CustomNavigationBar(screenWidth: screenWidth),
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
              DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: false,
                      indicatorColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.black,
                      tabs: [
                        Tab(
                          child: Text(
                            'Featured',
                            style: TextStyle(fontSize: screenWidth * 0.05),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'On Sale',
                            style: TextStyle(fontSize: screenWidth * 0.05),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Top Rated',
                            style: TextStyle(fontSize: screenWidth * 0.05),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          height: constraints.maxHeight, // Set the height of the TabBarView to the maximum height available
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              FeaturedPageView(scrollController: _scrollController),
                              OnSalePageView(),
                              TopRatedPageView(),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Image.asset('assets/img/sddefault.png'),
            ],
          ),
        ),
      ),
    );
  }
}

class FeaturedPageView extends StatelessWidget {
  const FeaturedPageView({Key? key, required this.scrollController})
      : super(key: key);

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final List<String> names = [
      'SAMSUNG Galaxy S24 Ultra, 128GB RAM +...',
      'Iphone 16 Pro Max, 159GB RAM SADASDASDASD',
      'SAMSUNG Galaxy S24 Ultra, 128GB RAM +...',
      'SAMSUNG Galaxy S24 Ultra, 128GB RAM +...',
    ];

    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FeaturedTab(screenWidth: screenWidth, screenHeight: screenHeight, names: names),
                FeaturedTab(screenWidth: screenWidth, screenHeight: screenHeight, names: names),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FeaturedTab(screenWidth: screenWidth, screenHeight: screenHeight, names: names),
                FeaturedTab(screenWidth: screenWidth, screenHeight: screenHeight, names: names),
              ],
            ),
          ],
        ),
      )
    );
  }
}

class FeaturedTab extends StatelessWidget {
  const FeaturedTab({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.names,
  });

  final double screenWidth;
  final double screenHeight;
  final List<String> names;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(screenWidth * 0.02),
      child: Container(
        width: screenWidth * 0.45,
        decoration: BoxDecoration(
          color: tdWhite,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(5.0, 5.0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                names[0],
                style: TextStyle(
                    fontSize: screenWidth * 0.025, color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Center(
                child: SizedBox(
                  width: screenWidth * 0.3,
                  child: Image.asset(
                    'assets/img/iphone.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '358.000 LB',
                    style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                  SvgPicture.asset(
                    'assets/svg/buy.svg',
                    width: screenWidth * 0.08,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              const Divider(),
              Text(
                'SKU: FT00962',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.033,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class TopRatedPageView extends StatelessWidget {
  const TopRatedPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class OnSalePageView extends StatelessWidget {
  const OnSalePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class FeaturedProductCard extends StatelessWidget {
  const FeaturedProductCard({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IntrinsicWidth(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ],
              color: tdWhiteNav),
          child: Row(
            children: [
              SizedBox(width: screenWidth * 0.05),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.02,
                    vertical: screenWidth * 0.01),
                child: SizedBox(
                    width: screenWidth * 0.3,
                    child: Image.asset(
                      'assets/img/camera.png',
                      fit: BoxFit.fill,
                    )),
              ),
              SizedBox(width: screenWidth * 0.04),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CATCH BIG',
                    style:
                        TextStyle(color: tdBlack, fontSize: screenWidth * 0.05),
                  ),
                  Row(
                    children: [
                      Text(
                        'DEALS ',
                        style: TextStyle(
                            color: tdBlack,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'ON THE',
                        style: TextStyle(
                            color: tdBlack, fontSize: screenWidth * 0.05),
                      )
                    ],
                  ),
                  Text(
                    'CAMERAS',
                    style:
                        TextStyle(fontSize: screenWidth * 0.05, color: tdBlack),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    'Shop now',
                    style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                        color: tdBlack),
                  )
                ],
              ),
              SizedBox(
                width: screenWidth * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OpeningImage extends StatelessWidget {
  const OpeningImage({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: screenHeight * 0.30,
        child: Image.network(
          'https://images.unsplash.com/photo-1468421201266-ec88b2809284?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          fit: BoxFit.fill,
        ));
  }
}

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            //notification bottom
          },
          child: badges.Badge(
            badgeContent: const Text(
              '8',
              style: TextStyle(color: tdWhite),
            ),
            badgeStyle: const badges.BadgeStyle(badgeColor: tdBlack),
            position: badges.BadgePosition.bottomEnd(),
            child: Image.asset(
              'assets/svg/notification.png',
              width: screenWidth * 0.07,
              fit: BoxFit.fill,
              color: tdBlack,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.06,
                        ),
                        Center(
                          child: Text(
                            'Search for products',
                            style: TextStyle(
                                fontSize: screenWidth * 0.025, color: tdGrey),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.09,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(left: BorderSide(color: Colors.black)),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50.0),
                    ),
                    color: tdBlack,
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                          vertical: screenWidth * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'All Categories',
                            style: TextStyle(
                                fontSize: screenWidth * 0.033, color: tdWhite),
                          ),
                          SizedBox(
                            width: screenWidth * 0.03,
                          ),
                          Container(
                              width: screenWidth * 0.07,
                              height: screenWidth * 0.07,
                              decoration: BoxDecoration(
                                  color: tdWhite,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.arrow_downward_sharp,
                                size: screenWidth * 0.05,
                                color: tdBlack,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            //notification bottom
          },
          child: badges.Badge(
            badgeContent: const Text(
              '3',
              style: TextStyle(color: tdWhite),
            ),
            badgeStyle: const badges.BadgeStyle(badgeColor: tdBlack),
            position: badges.BadgePosition.bottomEnd(),
            child: Image.asset(
              'assets/svg/cart.png',
              width: screenWidth * 0.07,
              fit: BoxFit.fill,
              color: tdBlack,
            ),
          ),
        ),
      ],
    );
  }
}

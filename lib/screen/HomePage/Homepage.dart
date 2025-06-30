import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Widget/Card/WeekDealCard.dart';
import 'package:zawiid/Widget/Drawer.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/core/ConnectivityCheck.dart';
import 'package:zawiid/core/config.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/model/offer/offer.dart';
import 'package:zawiid/provider/AppSetting_Provider.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/Banner_Provider.dart';
import 'package:zawiid/provider/Cart_Provider.dart';
import 'package:zawiid/provider/Categories_Provider.dart';
import 'package:zawiid/provider/NotificationProvider.dart';
import 'package:zawiid/provider/Offer_Provider.dart';
import 'package:zawiid/provider/Products_Provider.dart';
import 'package:zawiid/provider/User_Provider.dart';
import '../../model/Banner/Banner.dart';
import 'Details/TabView/FeaturedPage.dart';
import 'Details/TabView/OnSalePage.dart';
import 'Details/TabView/TopRatedPage.dart';
import '../../Widget/LoadingScreen/LoadingContainerHome.dart';
import 'Details/SearchBar/SearchBar.dart';
import 'Details/SubCategoryProduct/TopProductSubCategory.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController2 = PageController(initialPage: 0);
  int _currentPage2 = 0;
  final PageController _pageController1 = PageController(initialPage: 0);
  int _currentPage1 = 0;
  int _selectedCategoryIndex = 0;
  int _selectedSubcategoryIndex = 0;
  late Future<void> _fetchDataFuture;

  late StreamSubscription _connectionChangeStream;
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      GoRouter.of(context).goNamed('NotificationPage');
    });
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
    _fetchDataFuture = _fetchData();
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
      if (!isOffline) {
        _fetchDataFuture = _fetchData();
      }
    });
  }

  @override
  void dispose() {
    _connectionChangeStream.cancel();
    super.dispose();
  }

  Future<void> _fetchData() async {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final notificationProvider =
        Provider.of<NotificationsProvider>(context, listen: false);
    final offerProvider = Provider.of<OfferProvider>(context, listen: false);
    final cart = Provider.of<CartProvider>(context, listen: false);
    final setting = Provider.of<SettingsProvider>(context, listen: false);
    final banner = Provider.of<BannerProvider>(context, listen: false);
    try {
      final List<Future<dynamic>> fetchers = [
        cart.getAllCartOfUser(authProvider.userId),
        categoryProvider.getCategory(),
        setting.loadSettings(),
        notificationProvider.getAllNotifications(authProvider.userId),
        userProvider.getUserInfo(authProvider.userId),
        productProvider.getAllFeaturedProduct(),
        productProvider.getProductsOnSale(),
        productProvider.getProductsTopRated(),
        offerProvider.getAllOffer(),
        banner.getAllBanner()
      ];
      if (mounted) {
        await Future.wait(fetchers);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: true);
    var categories = categoryProvider.category;
    OfferProvider offerProvider =
        Provider.of<OfferProvider>(context, listen: true);
    List<Offer> offers = offerProvider.allOffer;
    final banner = Provider.of<BannerProvider>(context, listen: true);

    final firstBanner = banner.banners.firstWhere(
      (b) => b.bannerPosition == 'first',
      orElse: () => BannerModel.empty(),
    );
    final secondBanner = banner.banners.firstWhere(
      (b) => b.bannerPosition == 'second',
      orElse: () => BannerModel.empty(),
    );

    return Scaffold(
      key: HomePage.scaffoldKey,
      drawer: DrawerWithDropdown(),
      backgroundColor: tdWhite,
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: tdWhite,
          onRefresh: _fetchData,
          color: tdBlack,
          child: FutureBuilder(
            future: _fetchDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingContainerHome();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    S.of(context).errorConnection,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: tdGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 12.h),
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
                      if (firstBanner.bannerId == 0) ...[
                        const SizedBox(),
                      ] else ...[
                        SizedBox(
                          height: 200.h,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl:
                                '${ApiEndpoints.localBaseUrl}/${firstBanner.imageUrl}',
                            placeholder: (context, url) =>
                                Image.asset('assets/log/LOGO-icon---Black.png'),
                            errorWidget: (context, url, error) =>
                                Image.asset('assets/log/LOGO-icon---Black.png'),
                            fit: BoxFit.contain,
                          ),
                        )
                      ],
                      SizedBox(height: 10.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10).w,
                        child: Divider(
                          color: tdGrey,
                          thickness: 1.w,
                        ),
                      ),
                      SizedBox(height: 10.h),
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
                                      S.of(context).featured,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: _currentPage1 == 0
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: _currentPage1 == 0
                                            ? tdBlack
                                            : tdGrey,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 65.w,
                                    height: 1.h,
                                    decoration: BoxDecoration(
                                      color: _currentPage1 == 0
                                          ? tdBlack
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(4).w,
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
                                      S.of(context).onSale,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: _currentPage1 == 1
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: _currentPage1 == 1
                                            ? tdBlack
                                            : tdGrey,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 60.w,
                                    height: 1.h,
                                    decoration: BoxDecoration(
                                      color: _currentPage1 == 1
                                          ? tdBlack
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(4).w,
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
                                      S.of(context).latestDrop,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: _currentPage1 == 2
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: _currentPage1 == 2
                                            ? tdBlack
                                            : tdGrey,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70.w,
                                    height: 1.h,
                                    decoration: BoxDecoration(
                                      color: _currentPage1 == 2
                                          ? tdBlack
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(4).w,
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
                      if (secondBanner.bannerId == 0) ...[
                        const SizedBox(),
                      ] else ...[
                        Padding(
                          padding: const EdgeInsets.all(10).w,
                          child: Container(
                            height: 110.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: tdGreyHome,
                              borderRadius: BorderRadius.circular(10).w,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10).w,
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${ApiEndpoints.localBaseUrl}/${secondBanner.imageUrl}',
                                fit: BoxFit.fill,
                                placeholder: (context, url) => Image.asset(
                                    'assets/log/LOGO-icon---Black.png'),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                        'assets/log/LOGO-icon---Black.png'),
                              ),
                            ),
                          ),
                        )
                      ],
                      Padding(
                        padding: const EdgeInsets.all(10).w,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20).w,
                            color: tdGreyHome,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0).w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 3.h),
                                Text(
                                  S.of(context).weekDeals,
                                  style: TextStyle(
                                      fontSize: 12.sp, color: tdBlack),
                                ),
                                SizedBox(height: 2.h),
                                LinearProgressBar(
                                  minHeight: 0.5.h,
                                  maxSteps: 3,
                                  progressType:
                                      LinearProgressBar.progressTypeLinear,
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
                                  children: [
                                    if (offers.isEmpty)
                                      SizedBox(
                                        child: Center(
                                          child: Text(
                                            S.of(context).noOfferAvailable,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: tdGrey,
                                                fontSize: 12.sp),
                                          ),
                                        ),
                                      )
                                    else
                                      for (var offerProduct in offers) ...[
                                        WeekDealCard(offer: offerProduct),
                                      ]
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      categories.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: isArabic()
                                      ? const EdgeInsets.only(
                                              left: 5, right: 10)
                                          .w
                                      : const EdgeInsets.only(
                                              left: 10, right: 5)
                                          .w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        S.of(context).exploreProduct,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp),
                                      ),
                                      SizedBox(height: 3.h),
                                      Container(
                                        width: double.infinity,
                                        height: 1.h,
                                        color: tdGrey,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 160.w,
                                              height: 1.h,
                                              color: tdBlack,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      SizedBox(
                                        height: 35.h,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: categories.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _selectedCategoryIndex =
                                                      index;
                                                  _selectedSubcategoryIndex = 0;
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5).w,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: tdWhite,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        blurRadius: 5,
                                                        offset:
                                                            const Offset(0, 0),
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                                200)
                                                            .w,
                                                    border:
                                                        _selectedCategoryIndex ==
                                                                index
                                                            ? Border.all(
                                                                color: tdBlack,
                                                                width: 1.0.w)
                                                            : null,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                                left: 10,
                                                                right: 10)
                                                            .w,
                                                    child: Center(
                                                      child: Text(
                                                        categories[index]
                                                            .categoryName,
                                                        style: TextStyle(
                                                          color: tdBlack,
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35.h,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              categories[_selectedCategoryIndex]
                                                      .subcategories
                                                      ?.length ??
                                                  0,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _selectedSubcategoryIndex =
                                                      index;
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                        right: 7, bottom: 12)
                                                    .w,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                              left: 12,
                                                              right: 12)
                                                          .w,
                                                  child: Center(
                                                    child: Text(
                                                      categories[
                                                              _selectedCategoryIndex]
                                                          .subcategories![index]
                                                          .subCatName,
                                                      style: TextStyle(
                                                        color: tdBlack,
                                                        fontSize: 10.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5).w,
                                  child: categories.isNotEmpty &&
                                          categories[_selectedCategoryIndex]
                                                  .subcategories !=
                                              null &&
                                          categories[_selectedCategoryIndex]
                                              .subcategories!
                                              .isNotEmpty &&
                                          categories[_selectedCategoryIndex]
                                                  .subcategories!
                                                  .length >
                                              _selectedSubcategoryIndex &&
                                          categories[_selectedCategoryIndex]
                                                  .subcategories![
                                                      _selectedSubcategoryIndex]
                                                  .photo !=
                                              null
                                      ? Container(
                                          height: 500.h,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: tdGreyHome,
                                            borderRadius:
                                                BorderRadius.circular(20).w,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20).w,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  '${ApiEndpoints.localBaseUrl}/${categories[_selectedCategoryIndex].subcategories![_selectedSubcategoryIndex].photo ?? ""}',
                                              fit: BoxFit.fill,
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                      'assets/log/LOGO-icon---Black.png'),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.asset(
                                                      'assets/log/LOGO-icon---Black.png'),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ),
                                SizedBox(
                                  height: 500.h,
                                  child: categories[_selectedCategoryIndex]
                                                  .subcategories !=
                                              null &&
                                          categories[_selectedCategoryIndex]
                                              .subcategories!
                                              .isNotEmpty
                                      ? TopSubCategoryProduct(
                                          subCatID:
                                              categories[_selectedCategoryIndex]
                                                  .subcategories![
                                                      _selectedSubcategoryIndex]
                                                  .subCarNo)
                                      : Center(
                                          child: Text(
                                            S.of(context).noProductFound,
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                color: tdGrey),
                                          ),
                                        ),
                                ),
                              ],
                            )
                          : SizedBox(
                              width: 90.w,
                              height: 100.h,
                              child: Image.asset(
                                'assets/log/LOGO-icon---Black.png',
                                fit: BoxFit.contain,
                              ),
                            )
                    ],
                  ),
                );
              }
            },
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

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

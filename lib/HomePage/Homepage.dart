import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Classes/Featured/Featured.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/Products_Provider.dart';
import 'package:zawiid/provider/User_Provider.dart';
import '../ApiEndPoint.dart';
import '../Drawer/DrawerPage.dart';
import '../provider/Cart_Provider.dart';
import '../provider/Categories_Provider.dart';
import 'Widget/FeaturedProduct.dart';
import 'Widget/OpeningImage.dart';
import 'Widget/SearchBar.dart';
import 'Widget/SecondOpeningImage.dart';
import 'Widget/TabView/FeaturedPage.dart';
import 'Widget/TabView/OnSalePage.dart';
import 'Widget/TabView/TopRatedPage.dart';
import 'Widget/WeekDealCard.dart';
import 'ExploreProduct/ProductOfSubCatHomePage.dart';

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

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final productProvider = Provider.of<ProductsProvider>(context, listen: false);
    await Provider.of<CartProvider>(context, listen: false).getAllCartOfUser(authProvider.userId);
    await categoryProvider.getCategory();
    await userProvider.getUserInfo(authProvider.userId);
    await productProvider.getAllFeaturedProduct();
    await productProvider.getProductsOnSale();
    await productProvider.getProductsTopRated();
    await productProvider.getAllFeaturedProductCard();
  }

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context, listen: true);
    var categories = categoryProvider.category;
    ProductsProvider productProvider = Provider.of<ProductsProvider>(context, listen: true);

    List<Featured> getNewestFeaturedProducts(int count) {
      List<Featured> featuredProducts = productProvider.featuredProductCard;
      featuredProducts.sort((a, b) => b.startDate.compareTo(a.startDate));
      List<Featured> validFeaturedProducts = featuredProducts
          .where((product) =>
              product.startDate
                  .isBefore(DateTime.now().add(const Duration(days: 1))) &&
              product.endDate.isAfter(DateTime.now()))
          .toList();
      return validFeaturedProducts.take(count).toList();
    }

    List<Featured> newestFeaturedProducts = getNewestFeaturedProducts(3);

    return Scaffold(
      key: HomePage.scaffoldKey,
      drawer: DrawerWithDropdown(),
      backgroundColor: tdWhite,
      body: SafeArea(
        child: FutureBuilder(
          future: _fetchDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: tdBlack,),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Something went wrong, please try again later.',
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
                    const OpeningImage(),
                    SizedBox(height: 10.h),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          FeaturedProductCard(
                            text: 'iphone1231321313',
                          ),
                          FeaturedProductCard(
                            text: 'asdasdasdsd',
                          ),
                          FeaturedProductCard(
                            text: 'sd',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10).w,
                      child: Container(
                        height: 1.h,
                        color: tdGrey,
                        child: Row(
                          children: [
                            Container(
                              width: 113.w,
                              height: 2.h,
                              color: tdBlack,
                            ),
                            Container(
                              width: 113.w,
                              height: 2.h,
                              color: tdGrey,
                            ),
                            Container(
                              width: 113.w,
                              height: 2.h,
                              color: tdGrey,
                            )
                          ],
                        ),
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
                                    'Featured',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: _currentPage1 == 0
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color:
                                          _currentPage1 == 0 ? tdBlack : tdGrey,
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
                                    'On Sale',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: _currentPage1 == 1
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color:
                                          _currentPage1 == 1 ? tdBlack : tdGrey,
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
                                    'Top Rated',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: _currentPage1 == 2
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color:
                                          _currentPage1 == 2 ? tdBlack : tdGrey,
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
                    const SecondOpeningImage(),
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
                                'Week Deals Limited, Just now',
                                style:
                                    TextStyle(fontSize: 12.sp, color: tdBlack),
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
                                  if (newestFeaturedProducts.isEmpty)
                                    SizedBox(
                                      child: Center(
                                        child: Text(
                                          'No featured products available',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: tdGrey,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    )
                                  else
                                    for (var featuredProduct
                                        in newestFeaturedProducts)
                                      WeekDealCard(
                                        price:
                                            featuredProduct.products![0].price,
                                        image:
                                            '${ApiEndpoints.localBaseUrl}/${featuredProduct.products![0].productImage}',
                                        startDate: featuredProduct.startDate,
                                        endDate: featuredProduct.endDate,
                                        productNo: featuredProduct.products![0].productNo,
                                        colorNo: featuredProduct.products![0].colorNo,
                                        markNo: featuredProduct.products![0].markNo,
                                        salePrice: featuredProduct.products![0].discountedPrice,
                                      ),
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
                                padding:
                                    const EdgeInsets.only(left: 10, right: 5).w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Explore Our Product Range',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp),
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
                                                _selectedCategoryIndex = index;
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
                                                      BorderRadius.circular(200)
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
                                                        fontSize: 12.sp,
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
                                                padding: const EdgeInsets.only(
                                                        left: 12, right: 12)
                                                    .w,
                                                child: Center(
                                                  child: Text(
                                                    categories[
                                                            _selectedCategoryIndex]
                                                        .subcategories![index]
                                                        .subCatName,
                                                    style: TextStyle(
                                                      color: tdBlack,
                                                      fontSize: 12.sp,
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
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                '${ApiEndpoints.localBaseUrl}/${categories[_selectedCategoryIndex].subcategories![_selectedSubcategoryIndex].photo!}'),
                                            fit: BoxFit.cover,
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
                                    ? ProductsOfSubCategoriesHome(
                                        subCategoryId:
                                            categories[_selectedCategoryIndex]
                                                .subcategories![
                                                    _selectedSubcategoryIndex]
                                                .subCarNo)
                                    : Center(
                                        child: Text(
                                          'No products added yet',
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

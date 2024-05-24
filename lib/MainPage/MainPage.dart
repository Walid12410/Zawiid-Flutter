import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'EndedTab/EndedPage.dart';
import 'UpComingTab/UpComingPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 5.h),
            Padding(
              padding:  const EdgeInsets.only(left: 20, right: 40).w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).go('/home');
                    },
                    child: SizedBox(
                      width: 20.w,
                      height: 18.h,
                      child: Image.asset('assets/img/pop.png', fit: BoxFit.contain),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _handlePageTap(0);
                    },
                    child: Text(
                      'Upcoming',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: _currentPage == 0 ? FontWeight.bold : FontWeight.normal,
                        color: _currentPage == 0 ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _handlePageTap(1);
                    },
                    child: Text(
                      'Ended',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: _currentPage == 1 ? FontWeight.bold : FontWeight.normal,
                        color: _currentPage == 1 ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics:const NeverScrollableScrollPhysics(),
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page.toInt();
                  });
                },
                children: const [
                  UpComingTab(),
                  EndedTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handlePageTap(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    setState(() {
      _currentPage = page;
    });
  }
}

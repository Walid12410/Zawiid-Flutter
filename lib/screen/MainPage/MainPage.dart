import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/localization/generated/l10n.dart';
import 'EndedTab/EndedPage.dart';
import 'UpComingTab/UpComingPage.dart';
import 'package:intl/intl.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

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

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 5.h),
            Padding(
              padding: isArabic()? const EdgeInsets.only(right: 20, left: 40,top: 10).w :
              const EdgeInsets.only(left: 20, right: 40,top: 10).w,
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
                      S.of(context).upComing,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: _currentPage == 0 ? FontWeight.bold : FontWeight.normal,
                        color: _currentPage == 0 ? tdBlack : tdGrey,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _handlePageTap(1);
                    },
                    child: Text(
                      S.of(context).ended,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: _currentPage == 1 ? FontWeight.bold : FontWeight.normal,
                        color: _currentPage == 1 ? tdBlack : tdGrey,
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

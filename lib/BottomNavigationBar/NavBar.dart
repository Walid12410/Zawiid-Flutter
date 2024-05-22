import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/src/route.dart';
import '../Color&Icons/color.dart';
import '../Color&Icons/my_flutter_app_icons.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key, required this.navigationShell}) : super(key: key);

  final StatefulNavigationShell navigationShell;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: tdWhite,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: widget.navigationShell,
        ),
        bottomNavigationBar: Builder(builder: (context) {
          final mediaQuery = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQuery.removeViewPadding(
              removeBottom: true,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                right: 8 + mediaQuery.viewPadding.right,
                left: 8 + mediaQuery.viewPadding.left,
                bottom: 12 + mediaQuery.viewPadding.bottom,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: tdWhite,
                  borderRadius: BorderRadius.circular(100.0).w,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100).w,
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: tdWhite,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    selectedLabelStyle: const TextStyle(fontSize: 0),
                    unselectedLabelStyle: const TextStyle(fontSize: 0),
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                      _goBranch(selectedIndex);
                    },
                    currentIndex: selectedIndex,
                    items:  [
                      BottomNavigationBarItem(
                        icon: Icon(MyFlutterApp.home, color: tdIconColor,size: 20.w),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(MyFlutterApp.ticket,
                            color: tdIconColor, size: 33.w),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(MyFlutterApp.group_168,
                            color: tdBlack, size: 40.w),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(MyFlutterApp.profile, color: tdIconColor,size: 22.w,),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.percent_outlined,
                            color: tdIconColor, size: 25.w),
                        label: '',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}

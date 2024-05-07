import 'package:flutter/material.dart';
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
                top: 8,
                right: 8,
                left: 8,
                bottom: 8 + mediaQuery.viewPadding.bottom,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: tdWhite,
                  borderRadius: BorderRadius.circular(100.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 0.0,
                      offset: const Offset(5.0, 5.0),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: tdWhite,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                      _goBranch(selectedIndex);
                    },
                    currentIndex: selectedIndex,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(MyFlutterApp.home, color: tdIconColor),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(MyFlutterApp.ticket,
                            color: tdIconColor, size: 40),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(MyFlutterApp.group_168,
                            color: tdBlack, size: 40),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(MyFlutterApp.profile, color: tdIconColor),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.percent_outlined,
                            color: tdIconColor, size: 30),
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

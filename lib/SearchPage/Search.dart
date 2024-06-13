import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'Widget/SearchBar.dart';
import 'Widget/SearchHistoryCard.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
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
              SearchBarText(focusNode: _focusNode),
              SizedBox(height: 25.h),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 8).w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'RECENTLY VIEWED',
                      style: TextStyle(
                          fontSize: 9.sp,
                          color: tdGrey,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () {
                          //Clear History
                        },
                        child: Text(
                          'CLEAR',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 9.sp,
                              color: tdBlack),
                        ))
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SearchHistoryCard(),
                    SearchHistoryCard(),
                    SearchHistoryCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

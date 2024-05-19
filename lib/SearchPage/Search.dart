import 'package:flutter/material.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
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
              SearchBarText(screenWidth: screenWidth, screenHeight: screenHeight, focusNode: _focusNode),
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.04,right: screenWidth * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('RECENTLY VIEWED',style: TextStyle(fontSize: screenWidth * 0.033,color: tdGrey,fontWeight: FontWeight.bold),),
                    GestureDetector(
                        onTap: (){
                          //Clear History
                        },
                        child: Text('CLEAR',style: TextStyle(fontWeight: FontWeight.bold,fontSize: screenWidth * 0.033,color: tdBlack),))
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SearchHistoryCard(screenWidth: screenWidth, screenHeight: screenHeight),
                      SearchHistoryCard(screenWidth: screenWidth, screenHeight: screenHeight),
                      SearchHistoryCard(screenWidth: screenWidth, screenHeight: screenHeight),
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



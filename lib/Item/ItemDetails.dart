import 'package:flutter/material.dart';
import 'Widget/ItemBottoms.dart';
import 'Widget/ItemDetail.dart';
import 'Widget/ItemHead.dart';
import 'Widget/ItemPrice.dart';
import 'Widget/ItemShipping.dart';
import 'Widget/ItemTitle.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({super.key});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ItemDetailsHead(screenWidth: screenWidth, screenHeight: screenHeight),
              Padding(
                padding:  EdgeInsets.all(screenWidth * 0.03),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                          width: screenWidth * 0.7,
                          height: screenHeight * 0.4,
                          child: Image.asset('assets/img/iphone.png',fit: BoxFit.fill,)),
                    ),
                    SizedBox(height: screenHeight * 0.01,),
                    ItemTitle(screenWidth: screenWidth),
                    SizedBox(height: screenHeight * 0.02),
                    ItemPrice(screenWidth: screenWidth),
                    SizedBox(height: screenHeight * 0.02,),
                    ItemBottoms(screenWidth: screenWidth, screenHeight: screenHeight),
                    SizedBox(height: screenHeight * 0.02,),
                    ItemDetail(screenWidth: screenWidth, screenHeight: screenHeight),
                    SizedBox(height: screenHeight * 0.02,),
                    ItemShipping(screenWidth: screenWidth, screenHeight: screenHeight),
                    SizedBox(height: screenHeight * 0.04),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}







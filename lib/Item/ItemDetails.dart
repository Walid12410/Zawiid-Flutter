import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              const ItemDetailsHead(),
              Padding(
                padding:const EdgeInsets.all(8).w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                          width: 210.w,
                          height: 250.h,
                          child: Image.asset('assets/img/iphone.png',fit: BoxFit.fill,)),
                    ),
                    SizedBox(height: 10.h,),
                    const ItemTitle(),
                    SizedBox(height: 10.h,),
                    const ItemPrice(),
                    SizedBox(height: 10.h,),
                    const ItemBottoms(),
                    SizedBox(height: 10.h,),
                    const ItemDetail(),
                    SizedBox(height: 10.h,),
                    const ItemShipping(),
                    SizedBox(height: 10.h,),
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







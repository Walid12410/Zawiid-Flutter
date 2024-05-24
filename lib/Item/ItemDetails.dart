import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Widget/ItemBottoms.dart';
import 'Widget/ItemDetail.dart';
import 'Widget/ItemHead.dart';
import 'Widget/ItemPrice.dart';
import 'Widget/ItemShipping.dart';
import 'Widget/ItemTitle.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({super.key});

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  @override
  Widget build(BuildContext context) {

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







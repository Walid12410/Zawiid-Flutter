import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';

import 'Widget/CartContainer.dart';
import 'Widget/CartPageHead.dart';


class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CartPageHead(),
              SizedBox(height: 5.h),
              Padding(
                padding: const EdgeInsets.only(right: 8).w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Clear Cart',style: TextStyle(fontSize: 12.sp,color: tdBlack,fontWeight: FontWeight.bold ),)
                  ],
                ),
              ),
              const CartContainer(),
              const CartContainer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: tdWhite,
        color: tdWhite,
        height: 135.h,
        child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: tdGreyHome,
              borderRadius:const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50)
              ).w
            ),
            child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0).w,
                    child: Column(
                      children: [
                        SizedBox(height: 5.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Sub-Total:',style: TextStyle(color: tdBlack,fontSize: 12.sp),),
                            Text('00.00 KWD',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: tdBlack),)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivery:',style: TextStyle(color: tdBlack,fontSize: 12.sp),),
                            Text('0',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: tdBlack),)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('EST. Total:',style: TextStyle(color: tdBlack,fontSize: 12.sp),),
                            Text('00.00 KWD',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: tdBlack),)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        context.push(context.namedLocation('shippingAddress'));
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50).w,
                          border: Border.all(color: tdBlack),
                          color: tdWhite,
                        ),
                        child: Center(
                          child: Text('Select Address',style: TextStyle(fontWeight: FontWeight.bold,color: tdBlack,fontSize: 12.sp ),),
                        ),
                      ),
                    ),
                  )
                ],
              ),
          ),
      ),
    );
  }
}



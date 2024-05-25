import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'Widget/AddAddressBottom.dart';
import 'Widget/AddressDetails.dart';
import 'Widget/AddressViewHeading.dart';

class AddressView extends StatefulWidget {
  const AddressView({super.key, required this.showBottom});

  final bool showBottom;

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const AddressViewHeading(),
            SizedBox(height: 5.h),
            const AddAddressBottom(),
            const AddressDetails(),
            const AddressDetails(),
          ],
        ),
      )),
      bottomNavigationBar: widget.showBottom ? BottomAppBar(
        surfaceTintColor: tdWhite,
        color: tdWhite,
        height: 70.h,
        child: GestureDetector(
          onTap: (){
            context.push(context.namedLocation('payment'));
          },
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(border: Border.all(color: tdBlack),
            borderRadius: BorderRadius.circular(50).w),
            child: Center(
                child: Text(
              'Proceed to checkout',
              style: TextStyle(fontSize: 12.sp, color: tdBlack,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
          ),
        ),
      ) : null
    );
  }
}

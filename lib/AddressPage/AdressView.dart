import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/provider/Address_Provider.dart';
import '../provider/Auth_Provider.dart';
import '../provider/GovArea_Provider.dart';
import '../provider/User_Provider.dart';
import 'Widget/AddAddressBottom.dart';
import 'Widget/AddressDetails.dart';
import 'Widget/AddressViewHeading.dart';

class AddressView extends StatefulWidget {
  const AddressView({Key? key, required this.showBottom}) : super(key: key);

  final bool showBottom;

  @override
  _AddressViewState createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final addressProvider = Provider.of<AddressProvider>(context, listen: false);
    final govAreaProvider = Provider.of<GovAreaProvider>(context, listen: false);
    await govAreaProvider.getAllArea();
    await govAreaProvider.getAllGov();
    await addressProvider.getAddressByUserId(authProvider.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _fetchDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: SizedBox(
                width: 90.w,
                height: 100.h,
                child: Image.asset(
                  'assets/log/LOGO-icon---Black.png',
                  fit: BoxFit.contain,
                ),
              ));
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Something went wrong. Please check your connection.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: tdGrey,
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: tdWhite,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const AddressViewHeading(),
                    SizedBox(height: 5.h),
                    AddAddressBottom(showCheckOut: widget.showBottom),
                    const AddressDetails(),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: widget.showBottom
                ? BottomAppBar(
                    surfaceTintColor: tdWhite,
                    color: tdWhite,
                    height: 70.h,
                    child: GestureDetector(
                      onTap: () {
                        context.push(context.namedLocation('payment'));
                      },
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: tdBlack),
                          borderRadius: BorderRadius.circular(50).w,
                        ),
                        child: Center(
                          child: Text(
                            'Proceed to checkout',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: tdBlack,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  )
                : null,
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Widget/Header.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/provider/Address_Provider.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/GovArea_Provider.dart';
import 'Details/AddAddressBottom.dart';
import 'Details/AddressDetails.dart';

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

  Future<void> _selectAddressAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to dismiss the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: tdWhite,
          surfaceTintColor: tdWhite,
          title:  Text(S.of(context).selectAddress,style: TextStyle(fontSize: 12.sp
              ,color: tdBlack,fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(S.of(context).pickAddress,style: TextStyle(
                    fontSize: 10.sp,color: tdBlack
                ),),
              ],
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                width: 75.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100).w,
                  color: tdBlack,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5).w,
                  child: Center(child: Text(S.of(context).ok,style: TextStyle(fontWeight: FontWeight.bold,color: tdWhite,fontSize: 10.sp),)),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context, listen: true);
    return FutureBuilder<void>(
      future: _fetchDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: tdWhite,
            body: Center(
                child:CircularProgressIndicator(color: tdBlack,)),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: tdWhite,
            body: Center(
              child: Text(
                S.of(context).errorConnection,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  color: tdGrey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: tdWhite,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    PageHeadView(title: S.of(context).shippingAddress, onPressed: (){
                      context.pop();
                    }),
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
                        if(addressProvider.defaultAddressNo == -1 || addressProvider.defaultAddressNo == 0){
                          _selectAddressAlert();
                          return;
                        }
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
                            S.of(context).proceedCheckOut,
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

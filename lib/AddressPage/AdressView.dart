import 'package:flutter/material.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'Widget/AddAddressBottom.dart';
import 'Widget/AddressDetails.dart';
import 'Widget/AddressViewHeading.dart';

class AddressView extends StatefulWidget {
  const AddressView({super.key});

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const AddressViewHeading(),
                SizedBox(height: screenHeight * 0.01),
                const AddAddressBottom(),
                const AddressDetails(),
                const AddressDetails(),
                const AddressDetails(),

          ],
        ),
      )),
    );
  }
}

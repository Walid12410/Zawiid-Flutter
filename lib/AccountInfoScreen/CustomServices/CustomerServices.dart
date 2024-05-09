import 'package:flutter/material.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'Widget/CustomServicesContainer.dart';
import 'Widget/CustomerServiceHeading.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
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
              CustomerServiceHeading(screenWidth: screenWidth, screenHeight: screenHeight),
              CustomServicesContainer(screenHeight: screenHeight, screenWidth: screenWidth),
            ],
          ),
        ),
      ),
    );
  }
}






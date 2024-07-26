import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/PageHeadWidget.dart';
import 'Widget/CustomServicesContainer.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              PageHeadView(title: 'Customer Services', onPressed: (){
                GoRouter.of(context).go("/Profile");
              }),
              const CustomServicesContainer(),
            ],
          ),
        ),
      ),
    );
  }
}






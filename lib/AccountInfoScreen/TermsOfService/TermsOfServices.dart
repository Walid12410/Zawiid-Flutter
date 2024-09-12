import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/Widget/PageHeadWidget.dart';
import 'Widget/LegalInfoImage.dart';
import 'package:zawiid/generated/l10n.dart';


class TermsOfServices extends StatefulWidget {
  const TermsOfServices({super.key});

  @override
  State<TermsOfServices> createState() => _TermsOfServicesState();
}

class _TermsOfServicesState extends State<TermsOfServices> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Legal Information
              PageHeadView(title: S.of(context).legalInformation, onPressed: (){
                GoRouter.of(context).go("/Profile");
              }),
              SizedBox(height: 5.h,),
              const LegalInformationImage()
            ],
          ),
        ),
      ),
    );
  }
}



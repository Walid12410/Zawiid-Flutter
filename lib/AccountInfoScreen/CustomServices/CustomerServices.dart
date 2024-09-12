import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/Widget/PageHeadWidget.dart';
import '../../provider/AppSetting_Provider.dart';
import 'Widget/CustomServicesContainer.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/generated/l10n.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final setting = Provider.of<SettingsProvider>(context, listen: false);
      setting.loadSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<SettingsProvider>(context, listen: false);

    if (setting.settings.isEmpty) {
      return Scaffold(
        backgroundColor: tdWhite,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                S.of(context).errorConnection,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 12.sp, color: tdGrey),textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              PageHeadView(
                  title: S.of(context).customerSupport,
                  onPressed: () {
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

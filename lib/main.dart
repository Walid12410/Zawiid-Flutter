import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zawiid/Authentication/SignUp.dart';
import 'package:device_preview/device_preview.dart';
import 'package:zawiid/BottomNavigationBar/NavBar.dart';

import 'Route/RouteNaviagtor.dart';


void main() {
runApp(const MyApp());

  // runApp(DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) =>const  MyApp()));

}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      builder: DevicePreview.appBuilder,
      title: 'Zawiid',
      debugShowCheckedModeBanner: false,
      routerConfig: AppNavigation.router,
    );
  }
}

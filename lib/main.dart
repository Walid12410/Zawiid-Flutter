import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zawiid/provider/Address_Provider.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/Categories_Provider.dart';
import 'package:zawiid/provider/GovArea_Provider.dart';
import 'package:zawiid/provider/Products_Provider.dart';
import 'package:zawiid/provider/SelectionMarkColor_Provider.dart';
import 'package:zawiid/provider/User_Provider.dart';
import 'Route/RouteNaviagtor.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.getInt('userID') ?? 0;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ChangeNotifierProvider(create: (_) => ProductsProvider()),
      ChangeNotifierProvider(create: (_) => AuthProvider()..setUserId(userId)),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => GovAreaProvider()),
      ChangeNotifierProvider(create: (_) => AddressProvider()),
      ChangeNotifierProvider(create: (_) => MarkColorProvider()),

    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp.router(
          title: 'Zawiid',
          debugShowCheckedModeBanner: false,
          routerConfig: AppNavigation.router,
        )
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zawiid/core/ConnectivityCheck.dart';
import 'package:zawiid/core/LocalNotification.dart';
import 'package:zawiid/core/route/GoRouter.dart';
import 'package:zawiid/firebase/firebase_api.dart';
import 'package:zawiid/firebase/firebase_options.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/provider/Address_Provider.dart';
import 'package:zawiid/provider/AppSetting_Provider.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/Banner_Provider.dart';
import 'package:zawiid/provider/Bid_Provider.dart';
import 'package:zawiid/provider/Cart_Provider.dart';
import 'package:zawiid/provider/Categories_Provider.dart';
import 'package:zawiid/provider/Coupons_Provider.dart';
import 'package:zawiid/provider/Delivery_Provider.dart';
import 'package:zawiid/provider/GovArea_Provider.dart';
import 'package:zawiid/provider/Localization_Provider.dart';
import 'package:zawiid/provider/NotificationProvider.dart';
import 'package:zawiid/provider/Offer_Provider.dart';
import 'package:zawiid/provider/OrderProvider.dart';
import 'package:zawiid/provider/Products_Provider.dart';
import 'package:zawiid/provider/SelectionMarkColor_Provider.dart';
import 'package:zawiid/provider/User_Provider.dart';
import 'package:zawiid/provider/WithDrawal_Provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final GoRouter router = AppNavigation.router;
  final notificationService = NotificationService(router);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.getInt('userID') ?? 0;

  final localeProvider = LocaleProvider();
  await localeProvider.loadSavedLocale(); 

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()..setUserId(userId)),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ChangeNotifierProvider(create: (_) => NotificationsProvider()),
      ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => ProductsProvider()),
      ChangeNotifierProvider(create: (_) => OfferProvider()),
      ChangeNotifierProvider(create: (_) => OrderProvider()),
      ChangeNotifierProvider(create: (_) => GovAreaProvider()),
      ChangeNotifierProvider(create: (_) => AddressProvider()),
      ChangeNotifierProvider(create: (_) => MarkColorProvider()),
      ChangeNotifierProvider(create: (_) => BidProvider()),
      ChangeNotifierProvider(create: (_) => CouponsProvider()),
      ChangeNotifierProvider(create: (_) => TicketProvider()),
      ChangeNotifierProvider(create: (_) => DeliveryProvider()),
      ChangeNotifierProvider(create: (_) => BannerProvider()),
      ChangeNotifierProvider(create: (_) => localeProvider),
      Provider<NotificationService>.value(value: notificationService),
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
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await FirebaseApi().initNotifications(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        locale: localeProvider.locale,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        title: 'Zawiid',
        debugShowCheckedModeBanner: false,
        routerConfig: AppNavigation.router,
      ),
    );
  }
}

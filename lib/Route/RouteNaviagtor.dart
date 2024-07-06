import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/AddressPage/AdressView.dart';
import 'package:zawiid/Authentication/SignIn.dart';
import 'package:zawiid/Authentication/SignUp.dart';
import 'package:zawiid/BottomNavigationBar/NavBar.dart';
import 'package:zawiid/CoponsPage/Copons.dart';
import 'package:zawiid/CoponsPage/coponsDetails/CoponsDetails.dart';
import 'package:zawiid/HomePage/Homepage.dart';
import 'package:zawiid/MainPage/MainPage.dart';
import 'package:zawiid/OrderView/OrderView.dart';
import 'package:zawiid/Payment/payment.dart';
import 'package:zawiid/TicketPage/TicketPage.dart';

import '../AccountInfoScreen/CustomServices/CustomerServices.dart';
import '../AccountInfoScreen/PrivacyPolicyPage/privacy.dart';
import '../AccountInfoScreen/Profile.dart';
import '../AccountInfoScreen/TermsOfService/TermsOfServices.dart';
import '../AddAddress/AddAddress.dart';
import '../BidPage/BidPage.dart';
import '../CartPage/CartPage.dart';
import '../CoponsPage/CouponsPromotion/CouponsPromotion.dart';
import '../ForgetPassword/CodeReceive/CodeReceivePage.dart';
import '../ForgetPassword/ForgetPasswordPage.dart';
import '../ForgetPassword/NewPassword/NewPasswordPage.dart';
import '../Item/ItemDetails.dart';
import '../ItemAvariable/ItemAvariable.dart';
import '../NotificationPage/Notification.dart';
import '../Payment/ThanksPayment/ThanksPaymentPage.dart';
import '../SearchPage/Search.dart';
import '../UpdateProfile/updateProfile.dart';

class AppNavigation {
  AppNavigation._();

  static String initial = "/home";

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigatorTicket =
      GlobalKey<NavigatorState>(debugLabel: 'shellTicket');
  static final _shellNavigatorMain =
      GlobalKey<NavigatorState>(debugLabel: 'shellMain');
  static final _shellNavigatorProfile =
      GlobalKey<NavigatorState>(debugLabel: 'shellProfile');
  static final _shellNavigatorCoupons =
      GlobalKey<NavigatorState>(debugLabel: 'shellCoupons');

  static final GoRouter router = GoRouter(
    initialLocation: initial,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavBar(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: <RouteBase>[
              GoRoute(
                path: "/home",
                name: "Home",
                builder: (BuildContext context, GoRouterState state) =>
                    const HomePage(),
                routes: [
                  GoRoute(
                    path: 'itemDetails/:itemNo/:colorNo/:markNo',
                    name: 'itemDetails',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: ItemDetailsPage(
                        productNo: int.parse(state.pathParameters['itemNo']!),
                        colorNo: int.parse(
                          state.pathParameters['colorNo']!,
                        ),
                        markNo: int.parse(state.pathParameters['markNo']!),
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'SearchPage',
                    name: 'SearchPage',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const SearchPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'ItemViewCategories/:title/:categoryId',
                    name: 'ItemViewCategories',
                    pageBuilder: (BuildContext context, GoRouterState state) {
                      return CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: ItemViewCategories(
                            title: state.pathParameters['title']!,
                            categoryId:
                                int.parse(state.pathParameters['categoryId']!)),
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                      );
                    },
                  ),
                  GoRoute(
                    path: 'NotificationPage',
                    name: 'NotificationPage',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const NotificationPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorTicket,
            routes: <RouteBase>[
              GoRoute(
                path: "/Ticket",
                name: "Ticket",
                builder: (BuildContext context, GoRouterState state) =>
                    const TicketMain(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorMain,
            routes: <RouteBase>[
              GoRoute(
                  path: "/mainPage",
                  name: "MainPage",
                  builder: (BuildContext context, GoRouterState state) =>
                      const MainPage(),
                  routes: [
                    GoRoute(
                      path: 'BidPage/:bidNo/:productNo/:colorNo',
                      name: 'BidPage',
                      pageBuilder: (context, state) =>
                          CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: BidPage(
                          bidNo: int.parse(state.pathParameters['bidNo']!),
                          productNo:
                              int.parse(state.pathParameters['productNo']!),
                          colorNo: int.parse(state.pathParameters['colorNo']!),
                        ),
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            FadeTransition(opacity: animation, child: child),
                      ),
                    ),
                  ]),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfile,
            routes: <RouteBase>[
              GoRoute(
                path: "/profile",
                name: "Profile",
                builder: (BuildContext context, GoRouterState state) =>
                    const ProfileMain(),
                routes: [
                  GoRoute(
                    path: 'AddressView',
                    name: 'AddressView',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const AddressView(
                        showBottom: false,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'OrderView',
                    name: 'OrderView',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const OrderView(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'UpdateProfile',
                    name: 'UpdateProfile',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const UpdateProfile(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'AddAddressPage',
                    name: 'AddAddressPage',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const AddAddressPage(
                        isCheckOut: 0,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorCoupons,
            routes: <RouteBase>[
              GoRoute(
                path: "/coupons",
                name: "Coupons",
                builder: (BuildContext context, GoRouterState state) =>
                    const CouponsMain(),
                routes: [
                  GoRoute(
                    path: 'CouponsDetails/:markId/:couponsId',
                    name: 'CouponsDetails',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: CouponsDetails(
                        markId: int.parse(state.pathParameters['markId']!),
                        couponId: int.parse(state.pathParameters['couponsId']!),
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'CouponsPromotion/:couponsId',
                    name: 'CouponsPromotion',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: CouponsPromotion(
                        getCouponsID: int.parse(state.pathParameters['couponsId']!),
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/SignIn',
        name: "SignIn",
        builder: (context, state) => SignIn(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/itemDetailsView/:itemNo/:colorNo/:markNo',
        name: 'itemDetailsView/:itemNo/:colorNo/:markNo',
        builder: (context, state) => ItemDetailsPage(
          productNo: int.parse(state.pathParameters['itemNo']!),
          colorNo: int.parse(state.pathParameters['colorNo']!),
          markNo: int.parse(state.pathParameters['markNo']!),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/SignUp',
        name: "SignUp",
        builder: (context, state) => SignUp(
          key: state.pageKey,
        ),
      ),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/PrivacyPage',
          name: 'PrivacyPage',
          builder: (context, state) => PolicyPrivacy(
                key: state.pageKey,
              )),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/TermsOfServices',
          name: 'TermsOfServices',
          builder: (context, state) => TermsOfServices(
                key: state.pageKey,
              )),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/CustomerPage',
          name: 'CustomerPage',
          builder: (context, state) => CustomerPage(
                key: state.pageKey,
              )),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/CartPage',
          name: 'CartPage',
          builder: (context, state) => CartPage(
                key: state.pageKey,
              )),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/shippingAddress',
          name: 'shippingAddress',
          builder: (context, state) => AddressView(
                key: state.pageKey,
                showBottom: true,
              )),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/Payment',
          name: 'payment',
          builder: (context, state) => PaymentPage(
                key: state.pageKey,
              )),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/addAddress2',
          name: 'addAddress2',
          builder: (context, state) => AddAddressPage(
                key: state.pageKey,
                isCheckOut: 1,
              )),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/ThanksPayment',
          name: 'ThanksPayment',
          builder: (context, state) => ThanksPayment(
                key: state.pageKey,
              )),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/ForgetPassword',
          name: 'ForgetPassword',
          builder: (context, state) => ForgetPassword(
                key: state.pageKey,
              )),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/CodeReceivePage',
          name: 'CodeReceivePage',
          builder: (context, state) => CodeReceivePage(
                key: state.pageKey,
              )),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/NewPassword',
          name: 'NewPassword',
          builder: (context, state) => NewPassword(
                key: state.pageKey,
              )),
    ],
  );
}

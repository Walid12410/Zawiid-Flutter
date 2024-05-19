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
import 'package:zawiid/TicketPage/TicketPage.dart';

import '../AccountInfoScreen/CustomServices/CustomerServices.dart';
import '../AccountInfoScreen/PrivacyPolicyPage/privacy.dart';
import '../AccountInfoScreen/Profile.dart';
import '../AccountInfoScreen/TermsOfService/TermsOfServices.dart';


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
                // routes: [
                //   GoRoute(
                //     path: 'subHome',
                //     name: 'subHome',
                //     pageBuilder: (context, state) => CustomTransitionPage<void>(
                //       key: state.pageKey,
                //       child: const SubHomeView(),
                //       transitionsBuilder:
                //           (context, animation, secondaryAnimation, child) =>
                //           FadeTransition(opacity: animation, child: child),
                //     ),
                //   ),
                // ],
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
              ),
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
                      child: const AddressView(),
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
                    path: 'CouponsDetails',
                    name: 'CouponsDetails',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const CouponsDetails(),
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
        path: '/SignUp',
        name: "SignUp",
        builder: (context, state) => SignUp(
          key: state.pageKey,
        ),),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/PrivacyPage',
        name: 'PrivacyPage',
        builder: (context,state)=> PolicyPrivacy(
          key: state.pageKey,
        )
      ),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/TermsOfServices',
          name: 'TermsOfServices',
          builder: (context,state)=> TermsOfServices(
            key: state.pageKey,
          )
      ),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/CustomerPage',
          name: 'CustomerPage',
          builder: (context,state)=> CustomerPage(
            key: state.pageKey,
          )
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Widget/NavBar.dart';
import 'package:zawiid/screen/AccountInfoPage/CustomServicesPage/CustomerServices.dart';
import 'package:zawiid/screen/AccountInfoPage/PrivacyPolicyPage/privacy.dart';
import 'package:zawiid/screen/AccountInfoPage/Profile.dart';
import 'package:zawiid/screen/AccountInfoPage/TermsOfServicePage/TermsOfServices.dart';
import 'package:zawiid/screen/AddAddress/AddAddress.dart';
import 'package:zawiid/screen/AddressPage/AdressView.dart';
import 'package:zawiid/screen/Authentication/SignIn.dart';
import 'package:zawiid/screen/Authentication/SignUp.dart';
import 'package:zawiid/screen/BidPage/BidPage.dart';
import 'package:zawiid/screen/CartPage/CartPage.dart';
import 'package:zawiid/screen/ChatServicePages/ChatMessage.dart';
import 'package:zawiid/screen/CoponsPage/Copons.dart';
import 'package:zawiid/screen/CoponsPage/CouponsPromotionPage/CouponsPromotion.dart';
import 'package:zawiid/screen/CoponsPage/coponsDetailsPage/CoponsDetails.dart';
import 'package:zawiid/screen/ForgetPassword/CodeReceive/CodeReceivePage.dart';
import 'package:zawiid/screen/ForgetPassword/ForgetPasswordPage.dart';
import 'package:zawiid/screen/ForgetPassword/NewPasswordPage/NewPasswordPage.dart';
import 'package:zawiid/screen/HomePage/Homepage.dart';
import 'package:zawiid/screen/Item/ItemDetails.dart';
import 'package:zawiid/screen/ItemAvariable/ItemAvariable.dart';
import 'package:zawiid/screen/MainPage/MainPage.dart';
import 'package:zawiid/screen/NotificationPage/Notification.dart';
import 'package:zawiid/screen/OrderView/OrderView.dart';
import 'package:zawiid/screen/PaymentPage/ThanksPaymentPage/ThanksPaymentPage.dart';
import 'package:zawiid/screen/PaymentPage/payment.dart';
import 'package:zawiid/screen/SearchPage/Search.dart';
import 'package:zawiid/screen/TicketPage/TicketPage.dart';
import 'package:zawiid/screen/UpdateProfile/updateProfile.dart';


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
                        getCouponsID:
                            int.parse(state.pathParameters['couponsId']!),
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
          path: '/CustomerPage',
          name: 'CustomerPage',
          builder: (BuildContext context, GoRouterState state) =>
              const CustomerPage(),
          routes: [
            GoRoute(
              path: 'ChatPage/:chatRoomId',
              name: 'ChatPage',
              pageBuilder: (context, state) {
                final chatRoomId = int.parse(state.pathParameters['chatRoomId']!);
                return CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: ChatPage(chatRoomId: chatRoomId),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
                );
              },
            ),
          ]),
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

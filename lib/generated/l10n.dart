// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Search for products`
  String get searchTitle {
    return Intl.message(
      'Search for products',
      name: 'searchTitle',
      desc: '',
      args: [],
    );
  }

  /// `All Categories`
  String get allCategories {
    return Intl.message(
      'All Categories',
      name: 'allCategories',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, check your connection.`
  String get errorConnection {
    return Intl.message(
      'Something went wrong, check your connection.',
      name: 'errorConnection',
      desc: '',
      args: [],
    );
  }

  /// `Featured`
  String get featured {
    return Intl.message(
      'Featured',
      name: 'featured',
      desc: '',
      args: [],
    );
  }

  /// `On Sale`
  String get onSale {
    return Intl.message(
      'On Sale',
      name: 'onSale',
      desc: '',
      args: [],
    );
  }

  /// `Latest Drop`
  String get latestDrop {
    return Intl.message(
      'Latest Drop',
      name: 'latestDrop',
      desc: '',
      args: [],
    );
  }

  /// `No Offer available`
  String get noOfferAvailable {
    return Intl.message(
      'No Offer available',
      name: 'noOfferAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Week Deals Limited, Just now`
  String get weekDeals {
    return Intl.message(
      'Week Deals Limited, Just now',
      name: 'weekDeals',
      desc: '',
      args: [],
    );
  }

  /// `Explore Our Product Range`
  String get exploreProduct {
    return Intl.message(
      'Explore Our Product Range',
      name: 'exploreProduct',
      desc: '',
      args: [],
    );
  }

  /// `No products added yet`
  String get noProductFound {
    return Intl.message(
      'No products added yet',
      name: 'noProductFound',
      desc: '',
      args: [],
    );
  }

  /// `Hurry Up! Offer ends in:`
  String get hurryUpOffer {
    return Intl.message(
      'Hurry Up! Offer ends in:',
      name: 'hurryUpOffer',
      desc: '',
      args: [],
    );
  }

  /// `SKU`
  String get productCode {
    return Intl.message(
      'SKU',
      name: 'productCode',
      desc: '',
      args: [],
    );
  }

  /// `Login or SignUp please`
  String get loginError {
    return Intl.message(
      'Login or SignUp please',
      name: 'loginError',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Hour`
  String get hour {
    return Intl.message(
      'Hour',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get minutes {
    return Intl.message(
      'Minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `No subcategories available`
  String get noSubCategories {
    return Intl.message(
      'No subcategories available',
      name: 'noSubCategories',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want`
  String get areYouSure {
    return Intl.message(
      'Are you sure you want',
      name: 'areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `to clear your cart?`
  String get toClearCart {
    return Intl.message(
      'to clear your cart?',
      name: 'toClearCart',
      desc: '',
      args: [],
    );
  }

  /// `YES`
  String get yes {
    return Intl.message(
      'YES',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `NO`
  String get no {
    return Intl.message(
      'NO',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Clear Cart`
  String get clearCart {
    return Intl.message(
      'Clear Cart',
      name: 'clearCart',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty!`
  String get cartEmpty {
    return Intl.message(
      'Your cart is empty!',
      name: 'cartEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Sub-Total:`
  String get subtotal {
    return Intl.message(
      'Sub-Total:',
      name: 'subtotal',
      desc: '',
      args: [],
    );
  }

  /// `Delivery:`
  String get delivery {
    return Intl.message(
      'Delivery:',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `EST. Total`
  String get totalEstimation {
    return Intl.message(
      'EST. Total',
      name: 'totalEstimation',
      desc: '',
      args: [],
    );
  }

  /// `Select Address`
  String get selectAddress {
    return Intl.message(
      'Select Address',
      name: 'selectAddress',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Options`
  String get deliveryOptions {
    return Intl.message(
      'Delivery Options',
      name: 'deliveryOptions',
      desc: '',
      args: [],
    );
  }

  /// `to remove this item from the cart?`
  String get toRemoveItem {
    return Intl.message(
      'to remove this item from the cart?',
      name: 'toRemoveItem',
      desc: '',
      args: [],
    );
  }

  /// `Failed to delete cart item`
  String get failedToDelete {
    return Intl.message(
      'Failed to delete cart item',
      name: 'failedToDelete',
      desc: '',
      args: [],
    );
  }

  /// `Processing...`
  String get processing {
    return Intl.message(
      'Processing...',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Information`
  String get deliveryInformation {
    return Intl.message(
      'Delivery Information',
      name: 'deliveryInformation',
      desc: '',
      args: [],
    );
  }

  /// `Delivery is free.`
  String get deliveryFree {
    return Intl.message(
      'Delivery is free.',
      name: 'deliveryFree',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Select Delivery Option`
  String get selectDelivery {
    return Intl.message(
      'Select Delivery Option',
      name: 'selectDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Product not found`
  String get productNotFound {
    return Intl.message(
      'Product not found',
      name: 'productNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Product Details`
  String get productDetails {
    return Intl.message(
      'Product Details',
      name: 'productDetails',
      desc: '',
      args: [],
    );
  }

  /// `No details added yet.`
  String get noProductDetails {
    return Intl.message(
      'No details added yet.',
      name: 'noProductDetails',
      desc: '',
      args: [],
    );
  }

  /// `Remove from cart`
  String get removeFromCart {
    return Intl.message(
      'Remove from cart',
      name: 'removeFromCart',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get addToCart {
    return Intl.message(
      'Add to cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `But`
  String get buy {
    return Intl.message(
      'But',
      name: 'buy',
      desc: '',
      args: [],
    );
  }

  /// `Shipping`
  String get shipping {
    return Intl.message(
      'Shipping',
      name: 'shipping',
      desc: '',
      args: [],
    );
  }

  /// `Ticket`
  String get ticket {
    return Intl.message(
      'Ticket',
      name: 'ticket',
      desc: '',
      args: [],
    );
  }

  /// `Ticket Ended`
  String get ticketEnd {
    return Intl.message(
      'Ticket Ended',
      name: 'ticketEnd',
      desc: '',
      args: [],
    );
  }

  /// `Next ticket starts at`
  String get nextTicket {
    return Intl.message(
      'Next ticket starts at',
      name: 'nextTicket',
      desc: '',
      args: [],
    );
  }

  /// `New Ticket Is Upcoming Soon`
  String get newTicket {
    return Intl.message(
      'New Ticket Is Upcoming Soon',
      name: 'newTicket',
      desc: '',
      args: [],
    );
  }

  /// `Your Total Withdrawn Tickets`
  String get totalWithDraw {
    return Intl.message(
      'Your Total Withdrawn Tickets',
      name: 'totalWithDraw',
      desc: '',
      args: [],
    );
  }

  /// `PER TICKET`
  String get perTicket {
    return Intl.message(
      'PER TICKET',
      name: 'perTicket',
      desc: '',
      args: [],
    );
  }

  /// `tickets left`
  String get ticketLeft {
    return Intl.message(
      'tickets left',
      name: 'ticketLeft',
      desc: '',
      args: [],
    );
  }

  /// `Total Price:`
  String get totalPrice {
    return Intl.message(
      'Total Price:',
      name: 'totalPrice',
      desc: '',
      args: [],
    );
  }

  /// `Failed to enter the withdrawal`
  String get failedToWithDrawl {
    return Intl.message(
      'Failed to enter the withdrawal',
      name: 'failedToWithDrawl',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `ticket and enter`
  String get ticketEnter {
    return Intl.message(
      'ticket and enter',
      name: 'ticketEnter',
      desc: '',
      args: [],
    );
  }

  /// `A withdrawal on a `
  String get withDrawl {
    return Intl.message(
      'A withdrawal on a ',
      name: 'withDrawl',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `EDIT PROFILE`
  String get editProfile {
    return Intl.message(
      'EDIT PROFILE',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Customer Support`
  String get customerSupport {
    return Intl.message(
      'Customer Support',
      name: 'customerSupport',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Legal information`
  String get legalInformation {
    return Intl.message(
      'Legal information',
      name: 'legalInformation',
      desc: '',
      args: [],
    );
  }

  /// `All My Orders`
  String get allMyOrders {
    return Intl.message(
      'All My Orders',
      name: 'allMyOrders',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Address`
  String get shippingAddress {
    return Intl.message(
      'Shipping Address',
      name: 'shippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `LOG OUT`
  String get logOut {
    return Intl.message(
      'LOG OUT',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `LogIn`
  String get logIn {
    return Intl.message(
      'LogIn',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `SignUp`
  String get signUp {
    return Intl.message(
      'SignUp',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Tell us how we can help`
  String get tellUsHowToHelp {
    return Intl.message(
      'Tell us how we can help',
      name: 'tellUsHowToHelp',
      desc: '',
      args: [],
    );
  }

  /// `We’re here to help you at every step. Please look Through the options below and select what you’re looking for.`
  String get supportDetails {
    return Intl.message(
      'We’re here to help you at every step. Please look Through the options below and select what you’re looking for.',
      name: 'supportDetails',
      desc: '',
      args: [],
    );
  }

  /// `Call Us`
  String get callUs {
    return Intl.message(
      'Call Us',
      name: 'callUs',
      desc: '',
      args: [],
    );
  }

  /// `Email Us`
  String get emailUs {
    return Intl.message(
      'Email Us',
      name: 'emailUs',
      desc: '',
      args: [],
    );
  }

  /// `Chat Now`
  String get chatNow {
    return Intl.message(
      'Chat Now',
      name: 'chatNow',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Birthdate`
  String get birthDate {
    return Intl.message(
      'Birthdate',
      name: 'birthDate',
      desc: '',
      args: [],
    );
  }

  /// `Select Birth Date`
  String get selectBirth {
    return Intl.message(
      'Select Birth Date',
      name: 'selectBirth',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Select Governorate`
  String get gov {
    return Intl.message(
      'Select Governorate',
      name: 'gov',
      desc: '',
      args: [],
    );
  }

  /// `Area`
  String get area {
    return Intl.message(
      'Area',
      name: 'area',
      desc: '',
      args: [],
    );
  }

  /// `Please select Governorate and Area`
  String get pleaseSelectArea {
    return Intl.message(
      'Please select Governorate and Area',
      name: 'pleaseSelectArea',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get updateSuccessfully {
    return Intl.message(
      'Profile updated successfully',
      name: 'updateSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update profile`
  String get failedToUpdate {
    return Intl.message(
      'Failed to update profile',
      name: 'failedToUpdate',
      desc: '',
      args: [],
    );
  }

  /// `no order added yet`
  String get noOrderYet {
    return Intl.message(
      'no order added yet',
      name: 'noOrderYet',
      desc: '',
      args: [],
    );
  }

  /// `QTY`
  String get qty {
    return Intl.message(
      'QTY',
      name: 'qty',
      desc: '',
      args: [],
    );
  }

  /// `Pick your shipping address to complete your order.`
  String get pickAddress {
    return Intl.message(
      'Pick your shipping address to complete your order.',
      name: 'pickAddress',
      desc: '',
      args: [],
    );
  }

  /// `No addresses available. Please add a new address.`
  String get noAddressAvailable {
    return Intl.message(
      'No addresses available. Please add a new address.',
      name: 'noAddressAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Building`
  String get building {
    return Intl.message(
      'Building',
      name: 'building',
      desc: '',
      args: [],
    );
  }

  /// `default`
  String get defaults {
    return Intl.message(
      'default',
      name: 'defaults',
      desc: '',
      args: [],
    );
  }

  /// `Use as default`
  String get useDefault {
    return Intl.message(
      'Use as default',
      name: 'useDefault',
      desc: '',
      args: [],
    );
  }

  /// `Proceed to checkout`
  String get proceedCheckOut {
    return Intl.message(
      'Proceed to checkout',
      name: 'proceedCheckOut',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `ADD ADDRESS`
  String get addAddress {
    return Intl.message(
      'ADD ADDRESS',
      name: 'addAddress',
      desc: '',
      args: [],
    );
  }

  /// `UpComing`
  String get upComing {
    return Intl.message(
      'UpComing',
      name: 'upComing',
      desc: '',
      args: [],
    );
  }

  /// `Ended`
  String get ended {
    return Intl.message(
      'Ended',
      name: 'ended',
      desc: '',
      args: [],
    );
  }

  /// `zawiiidddd`
  String get zawiid {
    return Intl.message(
      'zawiiidddd',
      name: 'zawiid',
      desc: '',
      args: [],
    );
  }

  /// `Seconds`
  String get second {
    return Intl.message(
      'Seconds',
      name: 'second',
      desc: '',
      args: [],
    );
  }

  /// `No bid added yet`
  String get noBid {
    return Intl.message(
      'No bid added yet',
      name: 'noBid',
      desc: '',
      args: [],
    );
  }

  /// `Notification canceled!`
  String get notificationCancel {
    return Intl.message(
      'Notification canceled!',
      name: 'notificationCancel',
      desc: '',
      args: [],
    );
  }

  /// `Bid Start`
  String get bidStart {
    return Intl.message(
      'Bid Start',
      name: 'bidStart',
      desc: '',
      args: [],
    );
  }

  /// `Your bid for`
  String get bidFor {
    return Intl.message(
      'Your bid for',
      name: 'bidFor',
      desc: '',
      args: [],
    );
  }

  /// `is starting at`
  String get startAt {
    return Intl.message(
      'is starting at',
      name: 'startAt',
      desc: '',
      args: [],
    );
  }

  /// `Notification scheduled for bid start!`
  String get notificationScheduled {
    return Intl.message(
      'Notification scheduled for bid start!',
      name: 'notificationScheduled',
      desc: '',
      args: [],
    );
  }

  /// `Starting Price`
  String get startPrice {
    return Intl.message(
      'Starting Price',
      name: 'startPrice',
      desc: '',
      args: [],
    );
  }

  /// `Bid Ended`
  String get bidEnded {
    return Intl.message(
      'Bid Ended',
      name: 'bidEnded',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Notification`
  String get cancelNotify {
    return Intl.message(
      'Cancel Notification',
      name: 'cancelNotify',
      desc: '',
      args: [],
    );
  }

  /// `Notify Me!`
  String get notifyMe {
    return Intl.message(
      'Notify Me!',
      name: 'notifyMe',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Tomorrow`
  String get tomorrow {
    return Intl.message(
      'Tomorrow',
      name: 'tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `This Week`
  String get thisWeek {
    return Intl.message(
      'This Week',
      name: 'thisWeek',
      desc: '',
      args: [],
    );
  }

  /// `This Month`
  String get thisMonth {
    return Intl.message(
      'This Month',
      name: 'thisMonth',
      desc: '',
      args: [],
    );
  }

  /// `This Year`
  String get thisYear {
    return Intl.message(
      'This Year',
      name: 'thisYear',
      desc: '',
      args: [],
    );
  }

  /// `Nothing sold yet`
  String get nothingSold {
    return Intl.message(
      'Nothing sold yet',
      name: 'nothingSold',
      desc: '',
      args: [],
    );
  }

  /// `SOLD AT:`
  String get soldAt {
    return Intl.message(
      'SOLD AT:',
      name: 'soldAt',
      desc: '',
      args: [],
    );
  }

  /// `SOLD`
  String get sold {
    return Intl.message(
      'SOLD',
      name: 'sold',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

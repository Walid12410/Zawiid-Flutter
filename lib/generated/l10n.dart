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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/core/config.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/Cart_Provider.dart';
import 'package:zawiid/provider/Offer_Provider.dart';
import 'package:zawiid/provider/Products_Provider.dart';
import 'package:zawiid/provider/SelectionMarkColor_Provider.dart';
import 'Details/ItemBottoms.dart';
import 'Details/ItemDetail.dart';
import 'Details/ItemHead.dart';
import 'Details/ItemPrice.dart';
import 'Details/ItemShipping.dart';
import 'Details/ItemTitle.dart';
import 'package:intl/intl.dart';
import '../../Widget/LoadingScreen/LoadingContainerItem.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({
    Key? key,
    required this.productNo,
    required this.colorNo,
    required this.markNo,
  }) : super(key: key);

  final int productNo;
  final int markNo;
  final int colorNo;

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = fetchData();
  }

  Future<void> fetchData() async {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final offerProvider = Provider.of<OfferProvider>(context, listen: false);
    final colorMarkProvider =
        Provider.of<MarkColorProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final productNo = widget.productNo;
    final colorNo = widget.colorNo;
    final markNo = widget.markNo;
    final userId = authProvider.userId;

    try {
      final List<Future<dynamic>> fetchers = [
        productsProvider.getProductById(productNo),
        offerProvider.getOfferCheck(productNo),
        productsProvider.getProductDetailsById(productNo),
        colorMarkProvider.getColorById(colorNo),
        colorMarkProvider.getMarkById(markNo),
        cartProvider.getIfCartIsAdded(userId, productNo),
      ];
      await Future.wait(fetchers);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void didUpdateWidget(covariant ItemDetailsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.productNo != oldWidget.productNo ||
        widget.colorNo != oldWidget.colorNo ||
        widget.markNo != oldWidget.markNo) {
      setState(() {
        _fetchDataFuture = fetchData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: FutureBuilder<void>(
          future: _fetchDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingContainerItem();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  S.of(context).errorConnection,
                  style: TextStyle(
                    color: tdGrey,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              final productsProvider =
                  Provider.of<ProductsProvider>(context, listen: true);
              var product = productsProvider.productById;

              if (product.isEmpty || product[0].productNo != widget.productNo) {
                return Center(
                  child: Text(
                    S.of(context).productNotFound,
                    style: TextStyle(
                      color: tdBlack,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const ItemDetailsHead(),
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: SizedBox(
                              width: 210.w,
                              height: 250.h,
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${ApiEndpoints.localBaseUrl}/${product[0].productImage}',
                                placeholder: (context, url) => Image.asset(
                                  'assets/log/LOGO-icon---Black.png',
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/log/LOGO-icon---Black.png',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          const ItemTitle(),
                          SizedBox(height: 10.h),
                          ItemPrice(
                              price: double.parse(product[0].price),
                              discountedPrice:
                                  double.parse(product[0].discountedPrice)),
                          SizedBox(height: 10.h),
                          ItemBottoms(
                            productNo: product[0].productNo,
                            productPrice: double.parse(product[0].price),
                            productSalePrice:
                                double.parse(product[0].discountedPrice),
                          ),
                          SizedBox(height: 10.h),
                          const ItemDetail(),
                          SizedBox(height: 10.h),
                          const ItemShipping(),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

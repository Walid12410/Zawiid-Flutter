import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/Cart_Provider.dart';
import 'package:zawiid/provider/Offer_Provider.dart';
import 'package:zawiid/provider/Products_Provider.dart';
import 'package:zawiid/provider/SelectionMarkColor_Provider.dart';
import 'Widget/ItemBottoms.dart';
import 'Widget/ItemDetail.dart';
import 'Widget/ItemHead.dart';
import 'Widget/ItemPrice.dart';
import 'Widget/ItemShipping.dart';
import 'Widget/ItemTitle.dart';

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
    final productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    final offerCheck = Provider.of<OfferProvider>(context, listen: false);
    final colorMarkProvider = Provider.of<MarkColorProvider>(context, listen: false);
    final cartView = Provider.of<CartProvider>(context, listen: false);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    await productsProvider.getProductById(widget.productNo);
    await offerCheck.getOfferCheck(widget.productNo);
    await productsProvider.getProductDetailsById(widget.productNo);
    await colorMarkProvider.getColorById(widget.colorNo);
    await colorMarkProvider.getMarkById(widget.markNo);
    await cartView.getIfCartIsAdded(auth.userId, widget.productNo);
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
              return const Center(
                child: CircularProgressIndicator(
                  color: tdBlack,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Something went wrong, check your connection.',
                  style: TextStyle(
                      color: tdGrey,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold),
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
                    'Product not found',
                    style: TextStyle(
                        color: tdBlack,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const ItemDetailsHead(),
                    Padding(
                      padding: const EdgeInsets.all(8).w,
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
                                    'assets/log/LOGO-icon---Black.png'),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                        'assets/log/LOGO-icon---Black.png'),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          const ItemTitle(),
                          SizedBox(height: 10.h),
                          const ItemPrice(),
                          SizedBox(height: 10.h),
                          ItemBottoms(
                            productNo: product[0].productNo,
                            productPrice: product[0].price,
                            productSalePrice: product[0].discountedPrice,
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

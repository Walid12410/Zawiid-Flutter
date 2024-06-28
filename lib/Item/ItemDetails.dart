import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/provider/Products_Provider.dart';
import 'package:zawiid/provider/SelectionMarkColor_Provider.dart';
import 'Widget/ItemBottoms.dart';
import 'Widget/ItemDetail.dart';
import 'Widget/ItemHead.dart';
import 'Widget/ItemPrice.dart';
import 'Widget/ItemShipping.dart';
import 'Widget/ItemTitle.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({Key? key, required this.productNo, required this.colorNo, required this.markNo})
      : super(key: key);

  final int productNo;
  final int markNo;
  final int colorNo;

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  late Future<void> _fetchProductFuture;

  @override
  void initState() {
    super.initState();
    _fetchProductFuture = _fetchProductDetails();
  }

  Future<void> _fetchProductDetails() async {
    final productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    final colorMarkProvider = Provider.of<MarkColorProvider>(context, listen: false);
    await productsProvider.getProductById(widget.productNo);
    await colorMarkProvider.getColorById(widget.colorNo);
    await colorMarkProvider.getMarkById(widget.markNo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ItemDetailsHead(),
              FutureBuilder(
                future: _fetchProductFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SizedBox(
                        width: 90.w,
                        height: 100.h,
                        child: Image.asset(
                          'assets/log/LOGO-icon---Black.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Something went wrong, check your connection.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: Colors.grey, // Replace with your color
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return Consumer<ProductsProvider>(
                      builder: (context, productProvider, _) {
                        var product = productProvider.productById;

                        if (product.isEmpty) {
                          return Center(
                            child: Text(
                              'No product details available.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }
                        return Padding(
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
                                    imageUrl: '${ApiEndpoints.localBaseUrl}/${product[0].productImage}',
                                    placeholder: (context, url) =>
                                        Image.asset('assets/log/LOGO-icon---Black.png'),
                                    errorWidget: (context, url, error) =>
                                        Image.asset('assets/log/LOGO-icon---Black.png'),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              const ItemTitle(),
                              SizedBox(height: 10.h),
                              const ItemPrice(),
                              SizedBox(height: 10.h),
                              const ItemBottoms(),
                              SizedBox(height: 10.h),
                              const ItemDetail(),
                              SizedBox(height: 10.h),
                              const ItemShipping(),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

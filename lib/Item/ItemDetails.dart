import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/provider/Products_Provider.dart';
import 'package:zawiid/provider/SelectionMarkColor_Provider.dart';
import 'Widget/ItemBottoms.dart';
import 'Widget/ItemDetail.dart';
import 'Widget/ItemHead.dart';
import 'Widget/ItemPrice.dart';
import 'Widget/ItemShipping.dart';
import 'Widget/ItemTitle.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage(
      {Key? key,
      required this.productNo,
      required this.colorNo,
      required this.markNo})
      : super(key: key);

  final int productNo;
  final int markNo;
  final int colorNo;

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  @override
  void didUpdateWidget(covariant ItemDetailsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.productNo != widget.productNo ||
        oldWidget.colorNo != widget.colorNo ||
        oldWidget.markNo != widget.markNo) {
      _fetchProductDetails();
    }
  }

  Future<void> _fetchProductDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      final colorMarkProvider =
          Provider.of<MarkColorProvider>(context, listen: false);
      await productsProvider.getProductById(widget.productNo);
      await productsProvider.getProductDetailsById(widget.productNo);
      await colorMarkProvider.getColorById(widget.colorNo);
      await colorMarkProvider.getMarkById(widget.markNo);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Something went wrong, check your connection.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context, listen: true);
    var product = productsProvider.productById;

    if (product.isEmpty || product[0].productNo != widget.productNo) {
      return const Center(
        child: CircularProgressIndicator(
          color: tdBlack,
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ItemDetailsHead(),
              if (_isLoading)
                const Center(
                    child: CircularProgressIndicator(
                  color: tdBlack,
                ))
              else if (_errorMessage != null)
                Column(
                  children: [
                    SizedBox(height: 150.h),
                    Center(
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
              else if (product.isEmpty ||
                  product[0].productNo != widget.productNo)
                Center(
                  child: Text(
                    'No product details available.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

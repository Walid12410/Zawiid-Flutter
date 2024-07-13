import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/Cart_Provider.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final productsProvider = Provider.of<ProductsProvider>(context, listen: false);
      final colorMarkProvider = Provider.of<MarkColorProvider>(context, listen: false);
      final cartView = Provider.of<CartProvider>(context, listen: false);
      final auth = Provider.of<AuthProvider>(context, listen: false);
      productsProvider.getProductById(widget.productNo);
      productsProvider.getProductDetailsById(widget.productNo);
      colorMarkProvider.getColorById(widget.colorNo);
      colorMarkProvider.getMarkById(widget.markNo);
      cartView.getIfCartIsAdded(auth.userId, widget.productNo);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    var product = productsProvider.productById;
    if (product.isEmpty || product[0].productNo != widget.productNo) {
      return const Center(
        child: CircularProgressIndicator(color: tdBlack,)
      );
    }

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
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
    )));
  }
}

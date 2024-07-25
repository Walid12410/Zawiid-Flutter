import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/provider/Cart_Provider.dart';
import 'package:zawiid/provider/Products_Provider.dart';
import '../../Classes/Product/Products.dart';
import '../../provider/Auth_Provider.dart';
import 'DeleteProductFromCart.dart';

class CartContainer extends StatefulWidget {
  const CartContainer({
    Key? key,
    required this.productNo,
    required this.productCartPrice,
    required this.cartQuantity,
  }) : super(key: key);

  final int productNo;
  final String productCartPrice;
  final int cartQuantity;

  @override
  _CartContainerState createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
  late int _currentQuantity;
  late double _currentPrice;
  Product? _product;

  @override
  void initState() {
    super.initState();
    _currentQuantity = widget.cartQuantity;
    _currentPrice = double.parse(widget.productCartPrice);
    _fetchProductDetails();
  }

  Future<void> _fetchProductDetails() async {
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    List<Product> products =
        await productProvider.getProductOfCartByUserId(widget.productNo);
    if (products.isNotEmpty) {
      setState(() {
        _product = products[0];
      });
    }
  }

  Future<void> _updateCart(int newQuantity) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final userNo = authProvider.userId;
    await cartProvider.updateCartItem(
        userNo, widget.productNo, newQuantity, _currentPrice);
    setState(() {
      _currentQuantity = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (_product == null) {
      return const Center(child: CircularProgressIndicator(color: tdBlack));
    }

    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.w, left: 2.w),
                      child: SizedBox(
                        width: 70.w,
                        height: 90.h,
                        child: CachedNetworkImage(
                          imageUrl:
                              '${ApiEndpoints.localBaseUrl}/${_product!.productImage}',
                          placeholder: (context, url) =>
                              Image.asset('assets/log/LOGO-icon---Black.png'),
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/log/LOGO-icon---Black.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 110.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _product!.productName,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: tdBlack,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            width: 90.h,
                            child: Text(
                              _product!.productDesc,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: tdBlack,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            '${_currentPrice * _currentQuantity} KD',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: tdBlack,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            'SKU: FT00962',
                            style: TextStyle(fontSize: 4.sp, color: tdGrey),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 20.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.w),
                    color: tdWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (_currentQuantity > 1) {
                              _updateCart(_currentQuantity - 1);
                            } else {
                              showDeleteConfirmationDialog(context,
                                  authProvider.userId, widget.productNo);
                              setState(() {});
                            }
                          },
                          child: Icon(Icons.remove, color: tdGrey, size: 12.w),
                        ),
                        Text(
                          '$_currentQuantity',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: tdBlack,
                              fontSize: 10.sp),
                        ),
                        GestureDetector(
                          onTap: () {
                            _updateCart(_currentQuantity + 1);
                          },
                          child: Icon(Icons.add, color: tdGrey, size: 12.w),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

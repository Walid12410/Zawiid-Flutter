import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../ApiEndPoint.dart';
import '../../../Color&Icons/color.dart';
import '../../../provider/Products_Provider.dart';
import '../TabCard.dart';

class OnSalePageView extends StatefulWidget {
  const OnSalePageView({super.key});

  @override
  _OnSalePageViewState createState() => _OnSalePageViewState();
}

class _OnSalePageViewState extends State<OnSalePageView> {
  late Future<void> _fetchProductsFuture;

  @override
  void initState() {
    super.initState();
    _fetchProductsFuture = _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    await provider.getProductsOnSale();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchProductsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              SizedBox(height: 100.h,),
              Center(
                  child: SizedBox(
                    width: 90.w,
                    height: 100.h,
                    child: Image.asset(
                      'assets/log/LOGO-icon---Black.png',
                      fit: BoxFit.contain,
                    ),
                  )
              ),
              SizedBox(height: 100.h,),
            ],
          );
        } else if (snapshot.hasError) {
          return Column(
            children: [
              SizedBox(height: 100.h,),
              Center(
                child: Text(
                  'Something went wrong, check you connection.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                    color: tdGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 100.h,),
            ],
          );
        } else {
          return Consumer<ProductsProvider>(
            builder: (context, provider, _) {
              var onSaleProduct = provider.productOnSale;

              if (onSaleProduct.isEmpty) {
                return Center(
                  child: Text(
                    'No products added yet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: tdGrey,
                    ),
                  ),
                );
              }

              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: (onSaleProduct.length > 4)
                    ? 2
                    : (onSaleProduct.length / 2).ceil(),
                itemBuilder: (context, rowIndex) {
                  int startIndex = rowIndex * 2;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(2, (index) {
                      int productIndex = startIndex + index;
                      if (productIndex < onSaleProduct.length) {
                        return TabCard(
                          productName: onSaleProduct[productIndex].productName,
                          productDesc: onSaleProduct[productIndex].productDesc,
                          productImage:'${ApiEndpoints.localBaseUrl}/${onSaleProduct[productIndex].productImage}',
                          productPrice:onSaleProduct[productIndex].price
                        );
                      } else {
                        return const SizedBox();
                      }
                    }).toList(),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}

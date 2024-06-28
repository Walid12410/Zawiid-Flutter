import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../ApiEndPoint.dart';
import '../../../Color&Icons/color.dart';
import '../../../provider/Products_Provider.dart';
import '../TabCard.dart';

class TopRatedPageView extends StatefulWidget {
  const TopRatedPageView({super.key});

  @override
  _TopRatedPageViewState createState() => _TopRatedPageViewState();
}

class _TopRatedPageViewState extends State<TopRatedPageView> {
  late Future<void> _fetchProductsFuture;

  @override
  void initState() {
    super.initState();
    _fetchProductsFuture = _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    await provider.getProductsTopRated();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchProductsFuture,
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
              )
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Something went wrong, check you connection.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: tdGrey,
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return Consumer<ProductsProvider>(
            builder: (context, provider, _) {
              var productTopRated = provider.productTopRated;
              if (productTopRated.isEmpty) {
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
                itemCount: (productTopRated.length > 4)
                    ? 2
                    : (productTopRated.length / 2).ceil(),
                itemBuilder: (context, rowIndex) {
                  int startIndex = rowIndex * 2;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(2, (index) {
                      int productIndex = startIndex + index;
                      if (productIndex < productTopRated.length) {
                        return TabCard(
                          productNo: productTopRated[productIndex].productNo,
                          productName: productTopRated[productIndex].productName,
                          productDesc: productTopRated[productIndex].productDesc,
                          productImage:
                          '${ApiEndpoints.localBaseUrl}/${productTopRated[productIndex].productImage}',
                          productPrice: productTopRated[productIndex].price,
                          markNo: productTopRated[productIndex].markNo,
                          colorNo: productTopRated[productIndex].colorNo,
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

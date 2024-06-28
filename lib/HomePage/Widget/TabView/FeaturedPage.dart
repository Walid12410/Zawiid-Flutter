import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Classes/Featured/Featured.dart';
import '../../../ApiEndPoint.dart';
import '../../../Color&Icons/color.dart';
import '../../../provider/Products_Provider.dart';
import '../TabCard.dart';

class FeaturedPageView extends StatefulWidget {
  const FeaturedPageView({Key? key}) : super(key: key);

  @override
  _FeaturedPageViewState createState() => _FeaturedPageViewState();
}

class _FeaturedPageViewState extends State<FeaturedPageView> {
  Future<List<Featured>>? _futureFeaturedProducts;

  @override
  void initState() {
    super.initState();
    _futureFeaturedProducts = _fetchFeaturedProducts();
  }

  Future<List<Featured>> _fetchFeaturedProducts() async {
    ProductsProvider productProvider = Provider.of<ProductsProvider>(context, listen: false);
    await productProvider.getAllFeaturedProduct();
    return productProvider.featuredProduct;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return FutureBuilder<List<Featured>>(
      future: _futureFeaturedProducts,
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
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
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
          List<Featured> featuredProducts = snapshot.data!;
          List<Featured> activeFeaturedProducts = featuredProducts.where((featured) {
            DateTime endDate = featured.endDate;
            return endDate.isAfter(now) || endDate.isAtSameMomentAs(now);
          }).toList();

          List<Widget> rows = [];

          for (int i = 0; i < activeFeaturedProducts.take(4).length; i += 2) {
            List<Widget> cards = [];

            for (int j = 0; j < 2; j++) {
              if (i + j < activeFeaturedProducts.take(4).length) {
                var products = activeFeaturedProducts[i + j].products;

                cards.add(
                  Expanded(
                    child: TabCard(
                      productNo: products![0].productNo,
                      productName: products[0].productName,
                      productDesc: products[0].productDesc,
                      productImage: '${ApiEndpoints.localBaseUrl}/${products[0].productImage}',
                      productPrice: products[0].price,
                      markNo: products[0].markNo,
                      colorNo: products[0].colorNo,
                    ),
                  ),
                );
              } else {
                cards.add(
                  Expanded(
                    child: Container(),
                  ),
                );
              }
            }

            rows.add(
              Row(
                children: cards,
              ),
            );
          }

          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: rows.length,
            itemBuilder: (context, index) {
              return rows[index];
            },
          );
        }
      },
    );
  }
}

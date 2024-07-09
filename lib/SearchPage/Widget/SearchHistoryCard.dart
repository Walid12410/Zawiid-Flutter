import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../Classes/Product/Products.dart';
import '../../Color&Icons/color.dart';
import '../../ApiEndPoint.dart';

class SearchHistoryCard extends StatelessWidget {
  final Product product;

  const SearchHistoryCard({
    super.key, required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 8, bottom: 5,top: 5).w,
      child: GestureDetector(
        onTap: (){

        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5).w,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5,
              ),
            ],
            color: tdWhite,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 45.w,
                height: 45.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5).w,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5).w,
                  child: CachedNetworkImage(
                    imageUrl: '${ApiEndpoints.localBaseUrl}/${product.productImage}',
                    placeholder: (context, url) => Image.asset('assets/log/LOGO-icon---Black.png'),
                    errorWidget: (context, url, error) => Image.asset('assets/log/LOGO-icon---Black.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
             Padding(
                  padding: const EdgeInsets.all(5).w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: tdGrey,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${product.price}KD',
                        style: TextStyle(
                          color: tdGrey,
                          fontSize: 12.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

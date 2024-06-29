import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/ApiEndPoint.dart';

import '../../Color&Icons/color.dart';
import '../../provider/Products_Provider.dart';

class BidPageImage extends StatelessWidget {
  const BidPageImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProductsProvider productById = Provider.of<ProductsProvider>(context, listen: true);
    var product = productById.productById;
    String imagePath = '${ApiEndpoints.localBaseUrl}/${product[0].productImage}';
    return  Container(
        width: double.infinity,
        height: 230.h,
        decoration: BoxDecoration(
          color: tdWhite,
          borderRadius: BorderRadius.circular(15).w,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Center(
            child:  CachedNetworkImage(
              imageUrl: imagePath,
              placeholder: (context, url) =>
                  Image.asset('assets/log/LOGO-icon---Black.png'),
              errorWidget: (context, url, error) =>
                  Image.asset('assets/log/LOGO-icon---Black.png'),
              fit: BoxFit.contain,
            ),
        ),
      );
  }
}

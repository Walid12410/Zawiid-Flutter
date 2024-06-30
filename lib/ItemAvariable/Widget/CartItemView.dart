import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/ApiService/MarkColorService/MarkByIdApi.dart';
import 'package:zawiid/Classes/ColorAndMark/mark.dart';

import '../../ApiService/MarkColorService/ColorByIdApi.dart';
import '../../Classes/ColorAndMark/color.dart';
import '../../Color&Icons/color.dart';

class CartItemView extends StatefulWidget {
  const CartItemView(
      {super.key,
        required this.title,
        required this.mainPrice,
        required this.salePrice,
        required this.image,
        required this.markNo,
        required this.colorNo});

  final String title;
  final String mainPrice;
  final String salePrice;
  final String image;
  final int markNo;
  final int colorNo;

  @override
  _CartItemViewState createState() => _CartItemViewState();
}

class _CartItemViewState extends State<CartItemView> {
  ColorProduct? _colorProduct;
  Mark? _markProduct;

  @override
  void initState() {
    super.initState();
    _fetchColorDetails();
    _fetchMarkDetails();
  }

  Future<void> _fetchColorDetails() async {
    try {
      final List<ColorProduct> colorProducts =
      await fetchColorById(widget.colorNo);
      setState(() {
        _colorProduct = colorProducts.isNotEmpty ? colorProducts[0] : null;
      });
    } catch (e) {
      print('Error fetching color details: $e');
    }
  }

  Future<void> _fetchMarkDetails() async {
    try {
      final List<Mark> markProducts =
      await fetchMarkById(widget.markNo);
      setState(() {
        _markProduct = markProducts.isNotEmpty ? markProducts[0] : null;
      });
    } catch (e) {
      print('Error fetching mark details: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    final salePrice = double.tryParse(widget.salePrice) ?? 0.0;

    return Container(
      width: 160.w,
      decoration: BoxDecoration(
        color: tdWhite,
        borderRadius: BorderRadius.circular(10).w,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10.h),
          SizedBox(
            width: 90.w,
            height: 110.h,
            child: CachedNetworkImage(
              imageUrl: widget.image,
              placeholder: (context, url) => Image.asset('assets/log/LOGO-icon---Black.png'),
              errorWidget: (context, url, error) => Image.asset('assets/log/LOGO-icon---Black.png'),
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20).w,
            child: Text(
              _markProduct?.markName ?? "",
              style: TextStyle(
                  fontSize: 12.sp, color: tdBlack, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15).w,
            child: Text(
              '${widget.title} ${_colorProduct?.colorName ?? ""}',
              style: TextStyle(
                fontSize: 8.sp,
                color: tdBlack,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          SizedBox(height: 5.h),
          if (salePrice > 0.0) ...[
            Text(
              '${widget.salePrice} \$',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: Colors.red),
            ),
            Text(
              '${widget.mainPrice} \$',
              style: TextStyle(
                fontSize: 10.sp,
                color: tdBlack,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.lineThrough,
                decorationThickness: 2.5, // Adjust the thickness of the line through
                decorationColor: tdGrey,
              ),
            ),
          ] else ...[
            Text(
              '${widget.mainPrice} \$',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: tdBlack,
              ),
            ),
            Text("",style: TextStyle(fontSize: 10.sp),),
          ],
          SizedBox(height: 5.h),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10).w,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 25.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: tdBlack, borderRadius: BorderRadius.circular(5).w),
                child: Center(
                  child: Text(
                    'Add to cart',
                    style: TextStyle(fontSize: 8.sp, color: tdWhite),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5.h)
        ],
      ),
    );
  }
}

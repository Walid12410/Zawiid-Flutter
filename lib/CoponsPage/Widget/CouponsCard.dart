import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zawiid/Color&Icons/color.dart';

class CouponCard extends StatelessWidget {
  const CouponCard({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          context.push(context.namedLocation('CouponsDetails'));
        },
        child: Container(
          width: double.infinity,
          height: screenHeight * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: tdWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(4.0, 4.0),
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: double.infinity,
                height: screenHeight * 0.18,
                child: Image.asset('assets/img/adidas.png', fit: BoxFit.contain)),
          ),
        ),
      ),
    );
  }
}

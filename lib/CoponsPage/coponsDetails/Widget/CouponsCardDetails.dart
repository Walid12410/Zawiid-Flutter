import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../Color&Icons/color.dart';


class CouponsCardDetails extends StatelessWidget {
  const CouponsCardDetails({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              border:
              Border.all(color: const Color(-16214415)),
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding:
            EdgeInsets.only(top: screenWidth * 0.01),
            child: Column(
              children: [
                Text('40 %',
                    style: TextStyle(
                        fontSize: screenWidth * 0.025,
                        fontWeight: FontWeight.bold,
                        color: const Color(-16214415))),
                Text(
                  'OFF',
                  style: TextStyle(
                      fontSize: screenWidth * 0.025,
                      fontWeight: FontWeight.bold,
                      color: const Color(-16214415)),
                ),
                SizedBox(
                  height: screenHeight * 0.005,
                ),
                Container(
                    width: screenWidth * 0.10,
                    color: const Color(-16214415),
                    child:Center(
                      child: Text(
                        'Deal',
                        style: TextStyle(
                            color: tdWhite,
                            fontSize: screenWidth * 0.020),
                      ),
                    )),
              ],
            ),
          ),
        ),
        SizedBox(
          width: screenWidth * 0.02,
        ),
        SizedBox(
          width: screenWidth * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AdiClub Member Offer: Up to 40% Off For Member Only',
                style: TextStyle(
                    fontSize: screenWidth * 0.020,
                    fontWeight: FontWeight.bold,
                    color: tdBlack),
              ),
              SizedBox(height: screenHeight * 0.008),
              Row(
                children: [
                  Container(
                    color:tdGold,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.012,
                          right: screenWidth * 0.012),
                      child: Text(
                        'ADICLUB MEMBER',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: tdWhite,
                            fontSize: screenWidth * 0.020),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.02,
                  ),
                  Text(
                    'Expires in 1 day',
                    style: TextStyle(
                        fontSize: screenWidth * 0.020,
                        color: tdGrey),
                  )
                ],
              ),
              SizedBox(height: screenHeight * 0.008),
              ReadMoreText(
                'Adidas is a globally recognized sportswear brand renowned for its innovative designs, high-quality products, and impactful contributions to sports and fashion. Established in 1949 by Adolf "Adi" Dassler in Herzogenaurach, Germany, Adidas has grown into one of the largest and most influential athletic brands in the world. The companys iconic three-stripe logo is synonymous with performance, style, and authenticity.',
                trimMode: TrimMode.Length,
                trimLength: 62,
                style: TextStyle(fontSize: screenWidth * 0.020,color: tdGrey),
                colorClickableText: tdBlue,
                trimCollapsedText: 'More',
                trimExpandedText: 'Less',
                moreStyle: TextStyle(fontSize: screenWidth * 0.020,color: tdBlue,fontWeight: FontWeight.bold),
                lessStyle: TextStyle(fontSize: screenWidth * 0.020,color: tdBlue,fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                color: const Color(-9305855),
                child: Padding(
                  padding:  EdgeInsets.only(
                      top: screenWidth * 0.02,
                      bottom: screenWidth * 0.02,
                      left: screenWidth * 0.03,
                      right: screenWidth * 0.03
                  ),
                  child: Text('SHOW COUPON',style: TextStyle(fontWeight: FontWeight.bold,
                      color: tdWhite,fontSize: screenWidth * 0.025),),
                ),
              ),
              SizedBox(height: screenHeight * 0.01,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.wifi,size: screenWidth * 0.04,color: tdGrey,),
                      Text('23523 People Used',style: TextStyle(fontSize: screenWidth * 0.020,
                          color: tdGrey),)
                    ],
                  ),
                  const Row(
                    children: [
                      SizedBox()
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.share,size: screenWidth * 0.023,color: tdGrey,),
                      Text('Share',style: TextStyle(color: tdBlue,fontSize: screenWidth * 0.023),)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.email,size: screenWidth * 0.023,color: tdGrey,),
                      Text('Email',style: TextStyle(color: tdBlue,fontSize: screenWidth * 0.023),)
                    ],
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

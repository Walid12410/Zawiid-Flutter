import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';
import 'package:zawiid/Color&Icons/color.dart';

import 'Widget/CouponsCardHead.dart';

class CouponsDetails extends StatefulWidget {
  const CouponsDetails({super.key});

  @override
  State<CouponsDetails> createState() => _CouponsDetailsState();
}

class _CouponsDetailsState extends State<CouponsDetails> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.01),
              CouponsCardHead(screenWidth: screenWidth, screenHeight: screenHeight),
              TitleAndDescription(
                  screenWidth: screenWidth, screenHeight: screenHeight),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.03),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
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
                    padding: EdgeInsets.all(screenWidth * 0.01),
                    child: Column(
                      children: [
                        CouponsCardDetails(screenWidth: screenWidth, screenHeight: screenHeight),
                        SizedBox(height: screenHeight * 0.04),
                        CouponsCardDetails(screenWidth: screenWidth, screenHeight: screenHeight),
                        SizedBox(height: screenHeight * 0.04),
                        CouponsCardDetails(screenWidth: screenWidth, screenHeight: screenHeight),
                        SizedBox(height: screenHeight * 0.04),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


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

class TitleAndDescription extends StatelessWidget {
  const TitleAndDescription({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: screenWidth * 0.3,
            height: screenHeight * 0.1,
            child: Image.asset(
              'assets/img/adidas.png',
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Row(
            children: [
              Text(
                'Adidas',
                style: TextStyle(
                    fontSize: screenWidth * 0.042,
                    fontWeight: FontWeight.bold,
                    color: tdBlack),
              ),
              Text(
                ' Coupon & Promo Codes - April 2024',
                style: TextStyle(fontSize: screenWidth * 0.042, color: tdGrey),
              ),
            ],
          ),
          Text(
            'adidas.com.kw',
            style: TextStyle(
                fontSize: screenWidth * 0.025,
                color: tdBlue,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Text(
            'Adidas is the one-stop platform to purchase high-intensity sportswear and accessories in Kuwait. From its apparel to footwear, every new line is tested on the field so fitness enthusiasts and athletes can get the best products to break their PR and enhance their performance. Besides, you can grab the Adidas Promo Code from our website to avail yourself of great saving opportunities on all your Adidas shopping. Adidas believes in the power of sports, the significant impact they have on our lives and how they change us for the better. Its sports collection will reignite the passion of sports and fitness in you whether you love running, yoga, hiking, skateboarding or something else entirely. Furthermore, you needn’t worry about shopping for massive products from this sports giant with the Adidas Coupon Code. Adidas is loved by the Kuwaitis on the tracks, in the gym or another place because of its exclusively-made sportswear. You will find high tech sports apparel and footwear designed for athletes from football, training to golf and everything in between. Additionally, pay no attention to the retail value because by redeeming the Adidas Kuwait Promo Code, you will have knocked prices off by a big margin.',
            style: TextStyle(fontSize: screenWidth * 0.025, color: tdBlack),
          ),
        ],
      ),
    );
  }
}

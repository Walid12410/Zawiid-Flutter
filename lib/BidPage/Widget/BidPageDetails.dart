import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/ApiService/BidService//BidZawidApi.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import '../../Color&Icons/color.dart';
import '../../provider/Bid_Provider.dart';
import '../../provider/Products_Provider.dart';
import '../../provider/SelectionMarkColor_Provider.dart';
import '../WatchDown/WatchCount2.dart';

class BidPageDetails extends StatefulWidget {
  const BidPageDetails({
    super.key,
  });

  @override
  _BidPageDetailsState createState() => _BidPageDetailsState();
}

class _BidPageDetailsState extends State<BidPageDetails> {
  final TextEditingController _bidPriceController = TextEditingController();



  Future<void> _showConfirmationDialog(String bidAmount, int bidNo, int userNo) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: tdWhite,
          surfaceTintColor: tdWhite,
          title:  Text('Confirm Your Bid',style: TextStyle(fontSize: 12.sp
          ,color: tdBlack,fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to place a bid of $bidAmount KD?',style: TextStyle(
                  fontSize: 10.sp,color: tdBlack
                ),),
              ],
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                width: 75.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100).w,
                    color: tdWhite,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5).w,
                  child: Center(child: Text('Cancel',style: TextStyle(fontWeight: FontWeight.bold,color: tdBlack,fontSize: 10.sp),)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async{
               await addBidZawid(context,bidNo, userNo, bidAmount);
               Navigator.of(context).pop();
              },
              child: Container(
                width: 75.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100).w,
                  color: tdBlack,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5).w,
                  child: Center(child: Text('Confirm',style: TextStyle(fontWeight: FontWeight.bold,color: tdWhite,fontSize: 10.sp),)),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> _emptyController() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to dismiss the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: tdWhite,
          surfaceTintColor: tdWhite,
          title:  Text('Empty Field',style: TextStyle(fontSize: 12.sp
              ,color: tdBlack,fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Enter your bid price',style: TextStyle(
                    fontSize: 10.sp,color: tdBlack
                ),),
              ],
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                width: 75.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100).w,
                  color: tdBlack,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5).w,
                  child: Center(child: Text('OK',style: TextStyle(fontWeight: FontWeight.bold,color: tdWhite,fontSize: 10.sp),)),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> _higherBid() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to dismiss the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: tdWhite,
          surfaceTintColor: tdWhite,
          title:  Text('Place a Higher Bid',style: TextStyle(fontSize: 12.sp
              ,color: tdBlack,fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your current bid is too low. Please increase your bid price above the current bid to improve your chances of winning.',style: TextStyle(
                    fontSize: 10.sp,color: tdBlack
                ),),
              ],
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                width: 75.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100).w,
                  color: tdBlack,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5).w,
                  child: Center(child: Text('OK',style: TextStyle(fontWeight: FontWeight.bold,color: tdWhite,fontSize: 10.sp),)),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ProductsProvider productById = Provider.of<ProductsProvider>(context, listen: true);
    MarkColorProvider colorById = Provider.of<MarkColorProvider>(context, listen: true);
    BidProvider bidProvider = Provider.of<BidProvider>(context, listen: true);
    var bid = bidProvider.bidById;
    var color = colorById.oneColorByIDBid;
    var product = productById.productByIdBid;
    var latestBid = bidProvider.latestBid;
    var latestUserBid = bidProvider.latestUserBid;


    if (product.isEmpty || color.isEmpty || bid.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: tdBlack,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15).w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15.h,
          ),
          Text(
            '${product[0].productName} - ${color[0].colorName}',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: tdGrey, fontSize: 12.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            product[0].productDesc,
            style: TextStyle(fontSize: 8.sp, color: tdGrey),
          ),
          SizedBox(height: 30.h),
          Padding(
            padding: const EdgeInsets.only(right: 6).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Current Bid',
                  style: TextStyle(fontSize: 12.sp, color: tdGrey),
                ),
                Text(
                  'Your Last Bid',
                  style: TextStyle(fontSize: 12.sp, color: tdGrey),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${latestBid.isNotEmpty ? latestBid[0].zawidAmt : bid[0].startPrice} KD',
                style: TextStyle(
                    fontSize: 14.sp,
                    color: tdBlack,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '${latestUserBid.isNotEmpty ? latestUserBid[0].zawidAmt : 0} KD',
                style: TextStyle(fontSize: 14.sp, color: tdGrey),
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: Container(
              height: 30.h,
              width: 250.w,
              decoration: BoxDecoration(
                color: tdBlack,
                borderRadius: BorderRadius.circular(50).w,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 160.w,
                    decoration: BoxDecoration(
                      color: tdWhite,
                      borderRadius: BorderRadius.circular(50).w,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5).w,
                        child: TextField(
                          controller: _bidPriceController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d{0,9}(\.\d{0,4})?$')),
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Bid Price',
                            hintStyle: TextStyle(fontSize: 10.sp, color: tdGrey),
                          ),
                          style: TextStyle(fontSize: 10.sp, color: tdBlack),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      String bidAmount = _bidPriceController.text;
                      final auth = Provider.of<AuthProvider>(context, listen: false);
                      if(auth.userId == 0){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Login or SignUp please.',
                              style: TextStyle(fontSize: 10.sp, color: tdWhite),
                            ),
                            backgroundColor: tdBlack,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      if(bidAmount.isEmpty){
                        _emptyController();
                      }else{
                        await bidProvider.getLatestBid(bid[0].bidNo);
                        double currentBid = 0;
                        if (latestBid.isNotEmpty) {
                          currentBid = double.parse(latestBid[0].zawidAmt);
                        } else {
                          currentBid = double.parse(bid[0].startPrice);
                        }
                        if(double.parse(bidAmount) > currentBid){
                          await _showConfirmationDialog(bidAmount,bid[0].bidNo,auth.userId);
                          await bidProvider.getLatestUserBid(auth.userId, bid[0].bidNo);
                          await bidProvider.getLatestBid(bid[0].bidNo);
                        }else{
                          _higherBid();
                          await bidProvider.getLatestBid(bid[0].bidNo);
                        }

                      }
                    },
                    child: Container(
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ).w,
                        color: tdBlack,
                      ),
                      child: Center(
                        child: Text(
                          'Bid Now',
                          style: TextStyle(fontSize: 8.sp, color: tdWhite,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          CountdownTimerScreen2(
            endTime: bid[0].bidEndDate,
          )
        ],
      ),
    );
  }
}

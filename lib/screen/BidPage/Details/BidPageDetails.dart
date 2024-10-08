import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Api/BidService.dart';
import 'package:zawiid/Widget/SnackBar.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/localization/generated/l10n.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/Bid_Provider.dart';
import 'package:zawiid/provider/Products_Provider.dart';
import 'package:zawiid/provider/SelectionMarkColor_Provider.dart';
import '../WatchDown/WatchCount2.dart';
import 'package:intl/intl.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

class BidPageDetails extends StatefulWidget {
  const BidPageDetails({
    super.key,
  });

  @override
  _BidPageDetailsState createState() => _BidPageDetailsState();
}

class _BidPageDetailsState extends State<BidPageDetails> {
  final TextEditingController _bidPriceController = TextEditingController();
  bool _isLoading = false;


  Future<void> _showConfirmationDialog(String bidAmount, int bidNo, int userNo) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: tdWhite,
          surfaceTintColor: tdWhite,
          title:  Text(S.of(context).confirmBid,style: TextStyle(fontSize: 12.sp
              ,color: tdBlack,fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('${S.of(context).placeBid} $bidAmount \$?',style: TextStyle(
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
                  child: Center(child: Text(S.of(context).cancel,style: TextStyle(fontWeight: FontWeight.bold,color: tdBlack,fontSize: 10.sp),)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                BidService service = BidService();
                setState(() {
                  _isLoading = true;
                });
                bool success = await service.addBid(context, bidNo, userNo, bidAmount);
                if (success) {
                  setState(() {
                    showSnackBar(context, S.of(context).bidEntry);
                    Navigator.of(context).pop();
                  });
                } else {
                  setState(() {
                    showSnackBar(context,S.of(context).failedToAddBid);
                  });
                }
                setState(() {
                  _isLoading = false;
                });
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
                  child: Center(child: Text(S.of(context).confirm,style: TextStyle(fontWeight: FontWeight.bold,color: tdWhite,fontSize: 10.sp),)),
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
          title:  Text(S.of(context).emptyField,style: TextStyle(fontSize: 12.sp
              ,color: tdBlack,fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(S.of(context).enterBidPrice,style: TextStyle(
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
                  child: Center(child: Text(S.of(context).ok,style: TextStyle(fontWeight: FontWeight.bold,color: tdWhite,fontSize: 10.sp),)),
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
          title:  Text(S.of(context).placeHighBid,style: TextStyle(fontSize: 12.sp
              ,color: tdBlack,fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(S.of(context).placeHighBidMsg,style: TextStyle(
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
                  child: Center(child: Text(S.of(context).ok,style: TextStyle(fontWeight: FontWeight.bold,color: tdWhite,fontSize: 10.sp),)),
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
            padding:isArabic()? const EdgeInsets.only(left: 6).w :
            const EdgeInsets.only(right: 6).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).currentBid,
                  style: TextStyle(fontSize: 12.sp, color: tdGrey),
                ),
                Text(
                  S.of(context).lastBid,
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
                '${latestBid.isNotEmpty ? latestBid[0].zawidAmt : bid[0].startPrice} \$',
                style: TextStyle(
                    fontSize: 14.sp,
                    color: tdBlack,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '${latestUserBid.isNotEmpty ? latestUserBid[0].zawidAmt : 0} \$',
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
                          cursorColor: tdBlack,
                          controller: _bidPriceController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d{0,9}(\.\d{0,4})?$')),
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: S.of(context).enterBidPrice,
                            hintStyle: TextStyle(fontSize: 10.sp, color: tdGrey),
                          ),
                          style: TextStyle(fontSize: 10.sp, color: tdBlack),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _isLoading
                        ? null
                        : () async {
                      String bidAmount = _bidPriceController.text;
                      final auth = Provider.of<AuthProvider>(context, listen: false);
                      if(auth.userId == 0){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              S.of(context).loginError,
                              style: TextStyle(fontSize: 10.sp, color: tdWhite),
                            ),
                            backgroundColor: tdBlack,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      try{
                        setState(() {
                          _isLoading = true;
                        });
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
                      }catch(e){
                        throw Exception(e);
                      }finally{
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    child: Container(
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius:isArabic()? const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                        ).w : const BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ).w,
                        color: tdBlack,
                      ),
                      child: Center(
                        child: _isLoading
                            ? Text(S.of(context).processing, style: TextStyle(fontWeight: FontWeight.bold, color: tdWhite, fontSize: 8.sp),) : Text(
                           S.of(context).bidNow,
                          style: TextStyle(fontWeight: FontWeight.bold, color: tdWhite, fontSize: 8.sp),
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
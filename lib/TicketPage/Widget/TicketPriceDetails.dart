import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/ApiService/withDrawalService/withDrawalDetailsinertApi.dart';
import 'package:zawiid/ApiService/withDrawalService/withDrawalMainUpdate.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/provider/Auth_Provider.dart';

import '../../provider/WithDrawal_Provider.dart';

class TicketPriceDetails extends StatelessWidget {
  const TicketPriceDetails(
      {Key? key,
      required this.ticketPrice,
      required this.numberOfTicketLeft,
      required this.withDrawalNo})
      : super(key: key);

  final String ticketPrice;
  final int numberOfTicketLeft;
  final int withDrawalNo;

  @override
  Widget build(BuildContext context) {
    double price = double.parse(ticketPrice);
    int minTickets = 0;
    int maxTickets = numberOfTicketLeft;
    AuthProvider auth  = Provider.of<AuthProvider>(context, listen: false);

    void showTicketModal() {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      TicketProvider ticketProvider =
          Provider.of<TicketProvider>(context, listen: false);

      int ticketsCount = minTickets;
      bool isInvalidRange = false;

      showModalBottomSheet(
        backgroundColor: tdWhite,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              double totalTicketPrice = ticketsCount * price;
              return Container(
                height: 250.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${price.toStringAsFixed(2)}KD PER TICKET',
                      style: TextStyle(
                        color: tdGrey,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$numberOfTicketLeft ticket left',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: tdGrey),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            if (ticketsCount > minTickets) {
                              setState(() {
                                ticketsCount--;
                                isInvalidRange = false;
                                totalTicketPrice =
                                    ticketsCount * price; // Update total price
                              });
                            }
                          },
                          child: Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: const BoxDecoration(
                              color: tdBlack,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '-',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Text(
                          ticketsCount.toString(),
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 20.w),
                        GestureDetector(
                          onTap: () {
                            if (ticketsCount < maxTickets) {
                              setState(() {
                                ticketsCount++;
                                isInvalidRange = false;
                                totalTicketPrice = ticketsCount * price;
                              });
                            }
                          },
                          child: Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: const BoxDecoration(
                              color: tdBlack,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '+',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (isInvalidRange)
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Text(
                          'Sorry no ticket left.',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    SizedBox(height: 10.h),
                    Text(
                      'Total Price: ${totalTicketPrice.toStringAsFixed(2)}KD',
                      style: TextStyle(
                        color: tdGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () async {
                        if(ticketsCount == 0){
                          Navigator.pop(context);
                          return;
                        }
                        await addOrUpdateWithdrawalDetails(
                            nbrOfTicketsWithdrawn: ticketsCount,
                            ticketsTotalPrice: totalTicketPrice,
                            withDrawalID: withDrawalNo,
                            userNo: auth.userId,
                            ticketLeft: numberOfTicketLeft - ticketsCount,
                            context: context);
                        await ticketProvider.getAllTicket();
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200).w,
                            color: tdBlack),
                        child: Padding(
                          padding: const EdgeInsets.all(5).w,
                          child: Center(
                              child: Text(
                            'Confirm',
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: tdWhite,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    return GestureDetector(
      onTap: (){
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
        showTicketModal();
      },
      child: Container(
        width: 200.w,
        height: 30.h,
        decoration: BoxDecoration(
          color: tdWhite,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(0, 0),
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Text(
            '${price.toStringAsFixed(2)}KD TICKET',
            style: TextStyle(
              color: tdGrey,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

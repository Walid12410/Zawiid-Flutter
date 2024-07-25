import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/ApiService/withDrawalService/withDrawalDetailsinertApi.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/provider/Auth_Provider.dart';

import '../../ApiService/withDrawalService/withDrawalMainUpdate.dart';
import '../../provider/WithDrawal_Provider.dart';

class TicketPriceDetails extends StatefulWidget {
  const TicketPriceDetails({
    Key? key,
    required this.ticketPrice,
    required this.numberOfTicketLeft,
    required this.withDrawalNo,
  }) : super(key: key);

  final String ticketPrice;
  final int numberOfTicketLeft;
  final int withDrawalNo;

  @override
  _TicketPriceDetailsState createState() => _TicketPriceDetailsState();
}

class _TicketPriceDetailsState extends State<TicketPriceDetails> {
  late double price;
  late int minTickets;
  late int maxTickets;
  int ticketsCount = 0;
  bool isConfirming = false; // Track if confirmation process is ongoing

  @override
  void initState() {
    super.initState();
    price = double.parse(widget.ticketPrice);
    minTickets = 0;
    maxTickets = widget.numberOfTicketLeft;
  }

  void showTicketDialog(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    TicketProvider ticketProvider = Provider.of<TicketProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            double totalTicketPrice = ticketsCount * price;

            return AlertDialog(
              backgroundColor: tdWhite,
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Column(
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
                    '${widget.numberOfTicketLeft} tickets left',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: tdGrey,
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          if (ticketsCount > minTickets) {
                            setState(() {
                              ticketsCount--;
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
                  SizedBox(height: 10.h),
                  Text(
                    'Total Price: ${totalTicketPrice.toStringAsFixed(2)}KD',
                    style: TextStyle(
                      color: tdGrey,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    if (isConfirming) return;
                    isConfirming = true;
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: tdBlack,
                          ),
                        );
                      },
                    );

                    if (ticketsCount == 0) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      return;
                    }

                    bool status = await addOrUpdateWithdrawalDetails(
                      nbrOfTicketsWithdrawn: ticketsCount,
                      ticketsTotalPrice: totalTicketPrice,
                      withDrawalID: widget.withDrawalNo,
                      userNo: auth.userId,
                    );

                    if (status) {
                      bool status2 = await updateNbrOfTicketsLeft(
                        withdrawalID: widget.withDrawalNo,
                        nbrOfTicketsLeft: widget.numberOfTicketLeft - ticketsCount,
                      );
                      ticketProvider.getAllTicket();
                      if (status2) {
                        ticketProvider.getAllTicket();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Something went wrong',
                            style: TextStyle(fontSize: 10.sp, color: tdWhite),
                          ),
                          backgroundColor: tdBlack,
                          duration: const Duration(seconds: 4),
                        ),
                      );
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }

                    isConfirming = false;
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: tdBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: tdGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    TicketProvider ticketProvider = Provider.of<TicketProvider>(context, listen: true);

    return GestureDetector(
      onTap: () {
        if (auth.userId == 0) {
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
        ticketProvider.getAllTicket();
        showTicketDialog(context);
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

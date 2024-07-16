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

  void showTicketModal(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    TicketProvider ticketProvider = Provider.of<TicketProvider>(context, listen: false);

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
                    '${widget.numberOfTicketLeft} tickets left',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: tdGrey,
                    ),
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
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () async {
                      if (isConfirming) return; // Prevent multiple taps
                      isConfirming = true; // Set confirming state

                      if (ticketsCount == 0) {
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
                          Navigator.pop(context); // Close the modal bottom sheet
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
                      }

                      isConfirming = false; // Reset confirming state after completion
                    },
                    child: Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200).w,
                        color: tdBlack,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5).w,
                        child: Center(
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: tdWhite,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
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
        showTicketModal(context);
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

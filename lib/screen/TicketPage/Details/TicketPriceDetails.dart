import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Api/WithDrawalService.dart';
import 'package:zawiid/Widget/Toast/ToastError.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/WithDrawal_Provider.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

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

  void showTicketDialog(BuildContext context, int totalWithDrawl) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    TicketProvider ticketProvider =
        Provider.of<TicketProvider>(context, listen: false);

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return Future.value(false);
          },
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              double totalTicketPrice = ticketsCount * price;

              return AlertDialog(
                backgroundColor: tdWhite,
                surfaceTintColor: tdWhite,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                title: Column(
                  children: <Widget>[
                    totalWithDrawl != 0
                        ? Text(
                            '$totalWithDrawl ${S.of(context).totalWithDraw}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              color: tdGrey,
                            ),
                          )
                        : const SizedBox(),
                    Text(
                      '${price.toStringAsFixed(2)}\$ ${S.of(context).perTicket}',
                      style: TextStyle(
                        color: tdGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${widget.numberOfTicketLeft} ${S.of(context).ticketLeft}',
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
                      '${S.of(context).totalPrice} ${totalTicketPrice.toStringAsFixed(2)}\$',
                      style: TextStyle(
                        color: tdGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: isConfirming
                            ? null
                            : () async {
                                WithDrawalService service = WithDrawalService();

                                if (ticketsCount == 0) {
                                  Navigator.pop(context);
                                  return;
                                }
                                setState(() {
                                  isConfirming = true;
                                });
                                try {
                                  bool status = await service
                                      .addOrUpdateWithdrawalDetails(
                                    nbrOfTicketsWithdrawn: ticketsCount,
                                    ticketsTotalPrice: totalTicketPrice,
                                    withDrawalID: widget.withDrawalNo,
                                    userNo: auth.userId,
                                  );
                                  if (status) {
                                    bool status2 =
                                        await service.updateNbrOfTicketsLeft(
                                      withdrawalID: widget.withDrawalNo,
                                      nbrOfTicketsLeft:
                                          widget.numberOfTicketLeft -
                                              ticketsCount,
                                    );
                                    if (!status2) {
                                      setState(() {
                                        showToast(
                                            S.of(context).errorConnection);
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      showToast(S.of(context).errorConnection);
                                    });
                                  }
                                } catch (e) {
                                  setState(() {
                                    showToast(S.of(context).failedToWithDrawl);
                                  });
                                } finally {
                                  setState(() {
                                    Navigator.pop(context);
                                    ticketProvider.getTotalWithDrawlByUser(
                                        auth.userId, widget.withDrawalNo);
                                    ticketProvider.getAllTicket();
                                    isConfirming = false;
                                  });
                                }
                              },
                        child: Container(
                          width: 100.w,
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            color: tdWhite,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              isConfirming
                                  ? S.of(context).processing
                                  : S.of(context).confirm,
                              style: TextStyle(
                                fontSize: 9.sp,
                                color: tdBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      GestureDetector(
                        onTap: isConfirming
                            ? null
                            : () {
                                Navigator.of(context).pop();
                              },
                        child: Container(
                          width: 100.w,
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            color: tdBlack,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              S.of(context).cancel,
                              style: TextStyle(
                                fontSize: 9.sp,
                                color: tdWhite,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    TicketProvider ticketProvider =
        Provider.of<TicketProvider>(context, listen: true);

    int totalWithDrawl = 0;
    final totalWithDrawlByUser = ticketProvider.totalWithDL;

    if (totalWithDrawlByUser.isNotEmpty) {
      totalWithDrawl = totalWithDrawlByUser[0].totalTicketsWithdrawn;
    } else {
      totalWithDrawl = 0;
    }

    return GestureDetector(
      onTap: () {
        if (auth.userId == 0) {
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
        ticketProvider.getAllTicket();
        showTicketDialog(context, totalWithDrawl);
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
            '${price.toStringAsFixed(2)}\$ ${S.of(context).ticket}',
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

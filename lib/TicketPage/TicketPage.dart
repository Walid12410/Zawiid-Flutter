import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/provider/Products_Provider.dart';
import 'package:zawiid/provider/SelectionMarkColor_Provider.dart';
import 'package:zawiid/provider/WithDrawal_Provider.dart';
import 'Widget/ShowDetails.dart';
import 'Widget/TicketBackArrow.dart';
import 'Widget/TicketDetailsBottom.dart';
import 'Widget/TicketDetailsText.dart';
import 'Widget/TicketImage.dart';
import 'Widget/TicketPriceDetails.dart';

class TicketMain extends StatefulWidget {
  const TicketMain({super.key});

  @override
  State<TicketMain> createState() => _TicketMainState();
}

class _TicketMainState extends State<TicketMain> {
  bool _showDetails = true;
  bool _showDetailsBottom = true;

  void toggleVisibility() {
    setState(() {
      _showDetails = !_showDetails;
      _showDetailsBottom = !_showDetailsBottom;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      TicketProvider ticketProvider =
          Provider.of<TicketProvider>(context, listen: false);
      ticketProvider.getAllTicket();
    });
  }

  @override
  Widget build(BuildContext context) {
    TicketProvider ticketProvider = Provider.of<TicketProvider>(context, listen: true);
    ProductsProvider productData = Provider.of<ProductsProvider>(context, listen: true);
    MarkColorProvider markColorProvider = Provider.of<MarkColorProvider>(context, listen: true);

    var allTickets = ticketProvider.allTicket;
    var now = DateTime.now();

    if (allTickets.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: tdBlack),
      );
    }

    var startedTickets = allTickets
        .where((ticket) =>
            ticket.startDate.isBefore(now) && ticket.endDate.isAfter(now))
        .toList();
    var notStartedTickets = allTickets.where((ticket) => ticket.startDate.isAfter(now)).toList();
    var endedTickets = allTickets.where((ticket) => ticket.endDate.isBefore(now)).toList();

    if (startedTickets.isNotEmpty) {
      startedTickets.sort((a, b) => a.startDate.compareTo(b.startDate));
      var latestStartedTicket = startedTickets.first;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ProductsProvider productProvider =
            Provider.of<ProductsProvider>(context, listen: false);
        productProvider.getProductByIdTicket(latestStartedTicket.productNo);
      });

      var productDetails = productData.productByIdTicket;

      if (productDetails.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(color: tdBlack),
        );
      }

      if (productDetails != null || productDetails.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          MarkColorProvider markProvider =
              Provider.of<MarkColorProvider>(context, listen: false);
          markProvider.getMarkByIdTicket(productDetails[0].markNo);
          markProvider.getColorByIdTicket(productDetails[0].colorNo);
        });
      }

      var color = markColorProvider.oneColorByIDTicket;
      var mark = markColorProvider.oneMarkByIDTicket;

      if (color.isEmpty || mark.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(color: tdBlack),
        );
      }

      return Scaffold(
        backgroundColor: tdWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TicketBackArrow(),
                TicketImage(
                  ticketImage:
                      '${ApiEndpoints.localBaseUrl}/${productDetails[0].productImage}',
                ),
                if (_showDetails)
                  SizedBox(
                    height: 30.h,
                  ),
                if (_showDetailsBottom)
                  TicketDetailsBottom(onTap: toggleVisibility),
                if (_showDetails) ...[
                  SizedBox(
                    height: 10.h,
                  ),
                   TicketDetailsText(ticketPrice: latestStartedTicket.ticketPrice,),
                  SizedBox(
                    height: 15.h,
                  ),
                  TicketPriceDetails(
                      ticketPrice: latestStartedTicket.ticketPrice,
                  numberOfTicketLeft: latestStartedTicket.nbrOfTicketsLeft,
                  withDrawalNo: latestStartedTicket.withdrawalID,)
                ],
                if (!_showDetails)
                  TicketDetails(
                    onTap: toggleVisibility,
                    color: color[0].colorName,
                    mark: mark[0].markName,
                    productName: productDetails[0].productName,
                  ),
                SizedBox(
                  height: 15.h,
                )
              ],
            ),
          ),
        ),
      );
    } else if (notStartedTickets.isNotEmpty) {
      notStartedTickets.sort((a, b) => a.startDate.compareTo(b.startDate));
      var nextTicket = notStartedTickets.first;
      String formattedStartTime =
          DateFormat('dd MMMM yyyy hh:mm a').format(nextTicket.startDate);

      return Scaffold(
        backgroundColor: tdWhite,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: 50.w,
                  height: 70.h,
                  child: Image.asset(
                    'assets/log/LOGO-icon---Black.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                'Ticket Ended',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp,
                    color: tdGrey),
                textAlign: TextAlign.center,
              ),
              Text(
                'Next ticket starts at $formattedStartTime',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: tdGrey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: tdWhite,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: 50.w,
                  height: 70.h,
                  child: Image.asset(
                    'assets/log/LOGO-icon---Black.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                'Ticket Ended',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp,
                    color: tdGrey),
                textAlign: TextAlign.center,
              ),
              Text(
                  'New Ticket Is Upcoming Soon',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: tdGrey),
                  textAlign: TextAlign.center,
                ),

            ],
          ),
        ),
      );
    }
  }
}

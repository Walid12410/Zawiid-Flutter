import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Widget/Header.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/core/ConnectivityCheck.dart';
import 'package:zawiid/core/config.dart';
import 'package:zawiid/localization/generated/l10n.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/WithDrawal_Provider.dart';
import 'Details/LoadingContainer.dart';
import 'Details/ShowDetails.dart';
import 'Details/TicketDetailsBottom.dart';
import 'Details/TicketDetailsText.dart';
import 'Details/TicketImage.dart';
import 'Details/TicketPriceDetails.dart';
import 'package:intl/intl.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

class TicketMain extends StatefulWidget {
  const TicketMain({super.key});

  @override
  State<TicketMain> createState() => _TicketMainState();
}

class _TicketMainState extends State<TicketMain> {
  bool _showDetails = true;
  bool _showDetailsBottom = true;
  late StreamSubscription _connectionChangeStream;
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    _connectionChangeStream = connectionStatus.connectionChange.listen(connectionChanged);
    _fetchInitialData();
  }


  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
      if (!isOffline) {
        _fetchInitialData();
      }
    });
  }

  Future<void> _fetchInitialData() async {
    final ticketProvider = Provider.of<TicketProvider>(context, listen: false);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    await ticketProvider.getAllTicket();

    final allTickets = ticketProvider.allTicket;
    if (allTickets.isNotEmpty) {
      final now = DateTime.now();
      final startedTickets = allTickets
          .where((ticket) => ticket.startDate.isBefore(now) && ticket.endDate.isAfter(now))
          .toList();
      if (startedTickets.isNotEmpty) {
        final latestStartedTicket = startedTickets.first;
        await ticketProvider.getTotalWithDrawlByUser(auth.userId, latestStartedTicket.withdrawalID);
      }
    }
  }

  void toggleVisibility() {
    setState(() {
      _showDetails = !_showDetails;
      _showDetailsBottom = !_showDetailsBottom;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ticketProvider = Provider.of<TicketProvider>(context);

    final allTickets = ticketProvider.allTicket;
    final now = DateTime.now();


    if (allTickets.isEmpty) {
      return const LoadingContainerTicket();
    }

    final startedTickets = allTickets
        .where((ticket) => ticket.startDate.isBefore(now) && ticket.endDate.isAfter(now))
        .toList();
    final notStartedTickets = allTickets.where((ticket) => ticket.startDate.isAfter(now)).toList();
    final endedTickets = allTickets.where((ticket) => ticket.endDate.isBefore(now)).toList();

    if (startedTickets.isNotEmpty) {
      startedTickets.sort((a, b) => a.startDate.compareTo(b.startDate));
      final latestStartedTicket = startedTickets.first;


      return Scaffold(
        backgroundColor: tdWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PageHeadView(
                  title: S.of(context).ticket,
                  onPressed: () => GoRouter.of(context).go("/home"),
                ),
                TicketImage(
                  ticketImage: '${ApiEndpoints.localBaseUrl}/${latestStartedTicket.image}',
                ),
                if (_showDetails) SizedBox(height: 30.h),
                if (_showDetailsBottom)
                  TicketDetailsBottom(onTap: toggleVisibility),
                if (_showDetails) ...[
                  SizedBox(height: 10.h),
                  TicketDetailsText(
                    ticketPrice: latestStartedTicket.ticketPrice,
                    ticketTitle: latestStartedTicket.ticketTitle,
                  ),
                  SizedBox(height: 15.h),
                  TicketPriceDetails(
                    ticketPrice: latestStartedTicket.ticketPrice,
                    numberOfTicketLeft: latestStartedTicket.nbrOfTicketsLeft,
                    withDrawalNo: latestStartedTicket.withdrawalID,
                  )
                ],
                if (!_showDetails)
                  TicketDetails(
                    onTap: toggleVisibility,
                    color: latestStartedTicket.colorName,
                    mark: latestStartedTicket.markName,
                    productName: latestStartedTicket.productName,
                    size: latestStartedTicket.size,
                  ),
                SizedBox(height: 15.h),
              ],
            ),
          ),
        ),
      );
    } else if (notStartedTickets.isNotEmpty) {
      notStartedTickets.sort((a, b) => a.startDate.compareTo(b.startDate));
      final nextTicket = notStartedTickets.first;
      final formattedStartTime = DateFormat('dd MMMM yyyy hh:mm a').format(nextTicket.startDate);

      return Scaffold(
        backgroundColor: tdWhite,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLogo(),
              Text(
                S.of(context).ticketEnd,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp, color: tdGrey),
                textAlign: TextAlign.center,
              ),
              Text(
                '${S.of(context).nextTicket} $formattedStartTime',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp, color: tdGrey),
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
              _buildLogo(),
              Text(
                S.of(context).ticketEnd,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp, color: tdGrey),
                textAlign: TextAlign.center,
              ),
              Text(
               S.of(context).newTicket,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp, color: tdGrey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
  }


  Widget _buildLogo() {
    return Center(
      child: SizedBox(
        width: 50.w,
        height: 70.h,
        child: Image.asset(
          'assets/log/LOGO-icon---Black.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


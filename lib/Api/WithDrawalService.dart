import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:zawiid/core/config.dart';
import 'package:zawiid/model/WithDrawal/TotalWithDrawal.dart';
import 'package:zawiid/model/WithDrawal/withDrawalMain.dart';


class WithDrawalService {

Future<List<TotalWithDrawl>> fetchTotalWithDrawl(int userId, int withDrawlId) async {
  try {
    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/MobileApi/mobileTotalNbsWithDrawal.php?userNo=$userId&WithDrawalID=$withDrawlId'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<TotalWithDrawl> totalWithDrawl = jsonData.map((json) => TotalWithDrawl.fromJson(json)).toList();
      return totalWithDrawl;
    } else {
      throw Exception('Failed to load total WithDrawl by userId');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}

Future<bool> addOrUpdateWithdrawalDetails({
  required int nbrOfTicketsWithdrawn,
  required double ticketsTotalPrice,
  required int withDrawalID,
  required int userNo,
}) async {
  String apiUrl = '${ApiEndpoints.localBaseUrl}/webWithDrawalDetails.php?status=new';

  String date = DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US').format(DateTime.now());

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'WithDetDate': date,
        'NbrOfTicketsWithdrawn': nbrOfTicketsWithdrawn.toString(),
        'TicketsTotalPrice': ticketsTotalPrice.toString(),
        'WithDrawalID': withDrawalID.toString(),
        'UserNo': userNo.toString(),
      },
    );

    final jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse['message'] == 'Withdrawal details entry has been successfully added.') {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}


Future<List<Ticket>> fetchAllTicket() async {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd', 'en_US').format(now);
  try {

    final response = await http.get(Uri.parse('${ApiEndpoints.localBaseUrl}/MobileApi/mobileTicketVW.php'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Ticket> allTicket = jsonData.map((json) => Ticket.fromJson(json)).toList();
      return allTicket;
    } else {
      throw Exception('Failed to load all Ticket');
    }
  } catch (e) {
    throw Exception('Server Error');
  }
}


Future<bool> updateNbrOfTicketsLeft({
  required int withdrawalID,
  required int nbrOfTicketsLeft,
}) async {
  String apiUrl = '${ApiEndpoints.localBaseUrl}/webWithDrawalMain.php?status=updateTicketLeft';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'WithdrawalID': withdrawalID.toString(),
        'NbrOfTicketsLeft': nbrOfTicketsLeft.toString(),
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}


}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:zawiid/ApiEndPoint.dart';

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

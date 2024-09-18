import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';

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

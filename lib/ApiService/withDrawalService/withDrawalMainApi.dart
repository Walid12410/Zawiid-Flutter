import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Classes/WithDrawal/withDrawalMain.dart';

Future<List<Ticket>> fetchAllTicket() async {
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

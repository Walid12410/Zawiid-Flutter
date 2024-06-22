import 'dart:convert';
import 'package:zawiid/ApiEndPoint.dart';
import 'package:http/http.dart' as http;

class AddingAddress {
  Future<Map<String, dynamic>> insertAddress(
      String contactPhoneNum,
      int? gov,
      int? area,
      String block,
      String street,
      String building,
      String floor,
      int userNo) async {

    const url = '${ApiEndpoints.localBaseUrl}/webAddress.php?status=new';

    final Map<String, String> body = {
      'AddressType': 1.toString(),
      'ContactPhoneNumber': contactPhoneNum,
      'Governerate': gov.toString(),
      'Area': area.toString(),
      'Block': block,
      'Street': street,
      'Building': building,
      'Floor_Door': floor,
      'UserNo': userNo.toString(),
    };

    if(contactPhoneNum.isEmpty && block.isEmpty && street.isEmpty && building.isEmpty && floor.isEmpty){
      return {
        'success': false,
        'message': 'Some Field is empty',
      };
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return {
          'success': true,
          'message': responseData['message'],
        };
      } else {
        return {
          'success': false,
          'message': 'Something went wrong please try again later',
        };
      }
    } catch (error) {
      return {
        'success': false,
        'message': 'Something went wrong please try again later',
      };
    }
  }
}

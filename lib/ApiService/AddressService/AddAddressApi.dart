import 'dart:convert';
import 'package:zawiid/ApiEndPoint.dart';
import 'package:http/http.dart' as http;

class AddingAddress {
  Future<Map<String, dynamic>> insertAddress(
      String contactPhoneNum,
      String? gov,
      String? area,
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

    if(contactPhoneNum.isEmpty){
      return {
        'success': false,
        'message': 'Phone Number is required',
      };
    }
    if(block.isEmpty){
      return {
        'success': false,
        'message': 'Block field is required',
      };
    }
    if(street.isEmpty){
      return {
        'success': false,
        'message': 'Street field is required',
      };
    }

    if(building.isEmpty){
      return {
        'success': false,
        'message': 'Building field is required',
      };
    }
    if(floor.isEmpty){
      return {
        'success': false,
        'message': 'Floor/Door field is required',
      };
    }
    if(gov == null || gov == 0){
      return {
        'success': false,
        'message': 'Governorate field is required',
      };
    }
    if(area == null || area == 0){
      return {
        'success': false,
        'message': 'Area field is required',
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

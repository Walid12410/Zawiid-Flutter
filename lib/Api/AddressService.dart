import 'dart:convert';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/core/config.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:zawiid/model/Address/Address.dart';
import 'package:zawiid/provider/Address_Provider.dart';

class AddressService {
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

    if (contactPhoneNum.isEmpty) {
      return {
        'success': false,
        'message': 'Phone Number is required',
      };
    }
    if (block.isEmpty) {
      return {
        'success': false,
        'message': 'Block field is required',
      };
    }
    if (street.isEmpty) {
      return {
        'success': false,
        'message': 'Street field is required',
      };
    }

    if (building.isEmpty) {
      return {
        'success': false,
        'message': 'Building field is required',
      };
    }
    if (floor.isEmpty) {
      return {
        'success': false,
        'message': 'Floor/Door field is required',
      };
    }
    if (gov == null || gov == 0) {
      return {
        'success': false,
        'message': 'Governorate field is required',
      };
    }
    if (area == null || area == 0) {
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

  Future<void> deleteAddress(BuildContext context, int id) async {
    final url =
        '${ApiEndpoints.localBaseUrl}/webAddress.php?status=delete&id=$id';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Provider.of<AddressProvider>(context, listen: false).removeAddress(id);
        Provider.of<AddressProvider>(context, listen: false)
            .removeDefaultAddress();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Address deleted successfully',
              style: TextStyle(fontSize: 10.sp, color: tdWhite),
            ),
            backgroundColor: tdBlack,
            duration: const Duration(seconds: 1),
          ),
        );
      } else {
        throw Exception('Failed to delete address');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              'Failed to delete address',
              style: TextStyle(fontSize: 10.sp, color: tdWhite),
            ),
            backgroundColor: tdBlack,
            duration: const Duration(seconds: 1)),
      );
    }
  }

  Future<List<Address>> fetchAddressOfUser(int id) async {
    try {
      final response = await http.get(Uri.parse(
          '${ApiEndpoints.localBaseUrl}/webAddress.php?status=byUserNo&id=$id'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Address> viewAddress =
            jsonData.map((json) => Address.fromJson(json)).toList();
        return viewAddress;
      } else {
        throw Exception('Failed to load viewAddress');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }
}

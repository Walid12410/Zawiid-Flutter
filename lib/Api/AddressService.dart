import 'dart:convert';
import 'package:zawiid/Widget/Toast/ToastError.dart';
import 'package:zawiid/Widget/Toast/ToastSuccess.dart';
import 'package:zawiid/core/config.dart';
import 'package:http/http.dart' as http;
import 'package:zawiid/model/Address/Address.dart';

class AddressService {
  Future<bool> insertAddress(
      String contactPhoneNum,
      String gov,
      String area,
      String block,
      String street,
      String building,
      String floor,
      int userNo) async {
    const url = '${ApiEndpoints.localBaseUrl}/MobileApi/mobileAddAddress.php';
      final body = jsonEncode({
      'AddressType': 1,
      'ContactPhoneNumber': contactPhoneNum,
      'Governerate': int.parse(gov),
      'Area':int.parse(area),
      'Block': block,
      'Street': street,
      'Building': building,
      'Floor_Door': floor,
      'UserNo': userNo
    });
    print('hello');
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      final responseData = json.decode(response.body);
      if (response.statusCode == 201) {
        showToast(responseData['message']);
        return true;
      } else if (response.statusCode == 400) {
        showToast(responseData['message']);
        return false;
      } else {
        showToast('Something went wrong');
        return false;
      }
    } catch (error) {
      showToast('Something went wrong $error');
      return false;
    }
  }

  Future<bool> deleteOneAddress(int id) async {
    final url =
        '${ApiEndpoints.localBaseUrl}/webAddress.php?status=delete&id=$id';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        showSucessToast('Address deleted successfully');
        return true;
      } else {
        showToast('Failed to delete address');
        return false;
      }
    } catch (e) {
      showToast('Failed to delete address');
      return false;
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

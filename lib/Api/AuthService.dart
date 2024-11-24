import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zawiid/Widget/Toast/ToastError.dart';
import 'package:zawiid/Widget/Toast/ToastSuccess.dart';
import 'package:zawiid/Widget/Toast/ToastValidation.dart';
import 'package:zawiid/core/config.dart';

class Authentication {
  Future<bool> login(String email, String password) async {
    final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webLogin.php');

    try {
      final body = jsonEncode({'email': email, 'password': password});
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: body);

      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showSucessToast('Success');
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLogIn', true);
        prefs.setInt('userID', responseBody['UserNo']);
        return true;
      } else if (response.statusCode == 400) {
        showValidationToast(responseBody['message']);
        return false;
      } else {
        showToast('Something went wrong');
        return false;
      }
    } catch (e) {
      showToast('Something went wrong');
      return false;
    }
  }

  Future<bool> register(email, password) async {
    final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webSignup.php');
    try {
      final body = jsonEncode({'email': email, 'password': password});
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'}, body: body);
      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        showSucessToast(responseBody['message']);
        return true;
      } else if (response.statusCode == 400) {
        showValidationToast(responseBody['message']);
        return false;
      } else {
        showToast('Something went wrong');
        return false;
      }
    } catch (e) {
      showToast('Something went wrong');
      return false;
    }
  }
}

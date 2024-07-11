import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';


class AuthSignUpService {
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return {
        'success': false,
        'msg': 'Email or Password cannot be empty'
      };
    }

    final RegExp passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).{7,}$');
    if (!passwordRegex.hasMatch(password)) {
      return {
        'success': false,
        'msg': 'Password must be at least 7 characters long and contain at least one number'
      };
    }

    final List<String> allowedDomains = ['gmail.com', 'hotmail.com', 'yahoo.com'];
    if (!allowedDomains.any((domain) => email.endsWith('@$domain'))) {
      return {'success': false, 'msg': 'Email domain is not allowed'};
    }

    final Uri url = Uri.parse('${ApiEndpoints.localBaseUrl}/webSignup.php');

    final Map<String, String> body = {
      'Email': email,
      'Password': password,
      'UserName': email,
    };

    try {
      final http.Response response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['result'] == 'success') {
          return {'success': true, 'msg': 'Registration successful'};
        } else {
          return {'success': false, 'msg': responseData['msg']};
        }
      } else {
        return {
          'success': false,
          'msg': 'Something went wrong. Check your connection and try again later.'
        };
      }
    } catch (error) {
      return {'success': false, 'msg': 'Something went wrong. Check your connection and try again later.'};
    }
  }
}

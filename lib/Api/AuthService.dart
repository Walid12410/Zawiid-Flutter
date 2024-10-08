import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zawiid/core/config.dart';
import 'package:zawiid/provider/Auth_Provider.dart';


class AuthLoginService {
  Future<Map<String, dynamic>> login(String username, String password,BuildContext context) async {
      final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webLogin.php?username=$username&password=$password');
      if(username.isEmpty && password.isEmpty){
        return {'success': false, 'message': 'Username or Password cannot be empty'};
      }
      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          if (responseData['result'] == 'success') {
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool('isLogIn', true);
            prefs.setInt('userID', responseData['UserNo']);
            Provider.of<AuthProvider>(context,listen: false).setUserId(responseData['UserNo']);
            return {'success': true, 'data': responseData};
          } else {
            return {'success': false, 'message': 'Username or Password is wrong'};
          }
        } else {
          return {'success': false, 'message': 'Something went wrong. Check your connection and try again later.'};
        }
      } catch (error) {
        return {'success': false, 'message': 'Something went wrong. Check your connection and try again later.'};
      }
  }
}


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


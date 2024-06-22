import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import '../../ApiEndPoint.dart';

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

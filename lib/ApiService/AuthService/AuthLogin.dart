import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../ApiEndPoint.dart';

class AuthLoginService {
  Future<Map<String, dynamic>> login(String username, String password) async {
      final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webLogin.php?UserName=$username&Password=$password');
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

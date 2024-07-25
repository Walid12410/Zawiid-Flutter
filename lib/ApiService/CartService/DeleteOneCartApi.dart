import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';

Future<bool> deleteCart(int userNo, int productNo) async {
  try {
    final response = await http.post(
      Uri.parse('${ApiEndpoints.localBaseUrl}/webCart.php'),
      body: {
        'status': 'delete',
        'UserNo': userNo.toString(),
        'ProductNo': productNo.toString(),
      },
    );
    if (response.statusCode == 200) {
      final responseBody = response.body;
      if (responseBody.contains('error')) {
        return false;
      }
      return true;
    } else {
      return false;
    }
  } catch (error) {
    return false;
  }
}

import 'package:http/http.dart' as http;
import 'package:zawiid/ApiEndPoint.dart';

Future<bool> updateUserProfile(
    int id,
    String firstName,
    String lastName,
    String birthDate,
    String gender,
    String govNo,
    String areaNo,
    ) async {
  final url = Uri.parse('${ApiEndpoints.localBaseUrl}/webUser.php?status=update&id=$id');

  try {
    final response = await http.post(
      url,
      body: {
        'FirstName': firstName,
        'LastName': lastName,
        'BirthDate': birthDate,
        'Gender': gender,
        'GovNo': govNo,
        'AreaNo': areaNo,
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

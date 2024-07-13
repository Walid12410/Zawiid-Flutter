import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:zawiid/ApiEndPoint.dart';
import 'package:zawiid/Color&Icons/color.dart';

import '../../provider/Address_Provider.dart';

Future<void> deleteAddress(BuildContext context, int id) async {
  final url = '${ApiEndpoints.localBaseUrl}/webAddress.php?status=delete&id=$id';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Provider.of<AddressProvider>(context, listen: false).removeAddress(id);
      Provider.of<AddressProvider>(context, listen: false).removeDefaultAddress();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Address deleted successfully',style: TextStyle(fontSize: 10.sp,color: tdWhite),),backgroundColor: tdBlack,duration: const Duration(seconds: 1),),
      );
    } else {
      throw Exception('Failed to delete address');
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to delete address',style: TextStyle(fontSize: 10.sp,color: tdWhite),),backgroundColor: tdBlack,duration: const Duration(seconds: 1)),
    );
  }
}

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> shareCoupon(String title, String imageUrl) async {
   String link = 'zawiid.com/zawidApi/ShareApp/openApp.html'; // Replace with your link

  final message = 'Check out this coupon!\n$title\n$link';

  final http.Response response = await http.get(Uri.parse(imageUrl));
  final Directory directory = await getTemporaryDirectory();
  final File file = await File('${directory.path}/Image.png').writeAsBytes(response.bodyBytes);
  await Share.shareXFiles(
    [
      XFile(file.path),
    ],
    text: message,
  );
}

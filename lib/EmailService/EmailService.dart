import 'package:url_launcher/url_launcher.dart';

Future<void> sendEmailSupport(String email) async {
  try {

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    await launchUrl(emailLaunchUri);
  } catch (e) {
    throw Exception(e);
  }
}

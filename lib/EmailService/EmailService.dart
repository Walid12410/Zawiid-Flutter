import 'package:url_launcher/url_launcher.dart';

Future<void> sendEmailSupport() async {
  try {

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: '',
    );

    await launchUrl(emailLaunchUri);
  } catch (e) {
    throw Exception(e);
  }
}

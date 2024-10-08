import 'package:url_launcher/url_launcher.dart';
import 'package:zawiid/core/config.dart';

class EmailService {
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

  Future<void> sendEmail(String subject, String body) async {
    try {
      const String linkText = 'zawiid';
      const String linkUrl = ApiEndpoints.shareCouponsLink;
      final String formattedBody = '$body\n\n$linkText: $linkUrl';

      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: '',
        query:
            'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(formattedBody)}',
      );

      await launchUrl(emailLaunchUri);
    } catch (e) {
      throw Exception(e);
    }
  }
}

import "package:url_launcher/url_launcher.dart";

/// UrlLauncherService: Service for launching URLs
class UrlLauncherService {
  UrlLauncherService._();

  static Future<bool> launchUrlString(final String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return true;
    }
    return false;
  }
}

import 'package:Gametector/app/view/component/dialog/alert_gt_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(String url) async {
  final urlParsed = Uri.parse(url);
  if (await canLaunchUrl(urlParsed)) {
    await launchUrl(urlParsed, mode:LaunchMode.externalApplication);
  } else {
    showAlertGTDialog(
      message: 'Could not Launch $url',
    );
    throw 'Could not Launch $url';
  }
}

launchScheme(String scheme, String? url) async {
  final urlParsed = Uri.parse(url!);
  final schemeParsed = Uri.parse(scheme);
  if (await canLaunchUrl(schemeParsed)) {
    await launchUrl(schemeParsed);
  } else if (await canLaunchUrl(urlParsed)) {
    await launchUrl(urlParsed, mode:LaunchMode.externalApplication);
  } else {
    showAlertGTDialog(
      message: 'Could not Launch $url',
    );
    throw 'Could not Launch $url';
  }
}
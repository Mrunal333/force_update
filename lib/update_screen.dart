import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateScreen extends StatelessWidget {

  // ignore: constant_identifier_names
  static const PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=com.snapchat.android&hl=en_IN&gl=US';

  const UpdateScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Required'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Update the app to continue using it.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextButton(
              child: const Text('Update Now'),
              onPressed: () {
                // Redirect user to the app store for update
                _launchURL(PLAY_STORE_URL);
              },
            ),
          ],
        ),
      ),
    );
  }
  
    _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}

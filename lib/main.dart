import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';


void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MyApp());
}


class MyApp extends StatefulWidget {
   const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool updateRequired = false;
  Future<bool> isUpdateRequired() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.fetchAndActivate();
  final PackageInfo info = await PackageInfo.fromPlatform();
 // String currentVersion =  info.version;

  final bool updateRequired = remoteConfig.getBool('force_update');
  String currentVersion = remoteConfig.getString('current_version');
  log("current: ${remoteConfig.getString('current_version')}");
  String appVersion = remoteConfig.getString('app_version');
  log("App Version is: $appVersion");
  log("Current Version is: $currentVersion");
  log("update bool value: $updateRequired");
 
  return updateRequired && currentVersion.compareTo(appVersion) != 0 ;
}

Future<void> setupRemoteConfig() async {

  //final RemoteConfig remoteConfig = RemoteConfig.instance;
  final remoteConfig = FirebaseRemoteConfig.instance;
  
  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
     fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 1),
  ));
  
  await remoteConfig.fetchAndActivate();
}

  @override
   void initState() {
    super.initState();
     setupRemoteConfig().then((value) async => 
     
      updateRequired = await isUpdateRequired());
   
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'My App',
      home: updateRequired ? const UpdateScreen() : const HomeScreen(),
    );
  }
}

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


class HomeScreen extends StatelessWidget{

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(home: Text("Free Doctor"));
  }

}

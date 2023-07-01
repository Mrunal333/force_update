// // ignore_for_file: constant_identifier_names

// import 'dart:developer';
// import 'dart:io';


// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:package_info/package_info.dart';
// import 'package:url_launcher/url_launcher.dart';

// class CheckUpdate {
//   static const APP_STORE_URL = 'https://apps.apple.com/us/app/appname/idAPP-ID';
//   static const PLAY_STORE_URL =
//       'https://play.google.com/store/apps/details?id=com.freedoctor1.application&pli=1';

//   versionCheck(context) async {
//     //Get Current installed version of app
//     final PackageInfo info = await PackageInfo.fromPlatform();
//     double currentVersion =
//         double.parse(info.version.trim().replaceAll(".", ""));

//     //Get Latest version info from firebase config
//     final remoteConfig = FirebaseRemoteConfig.instance;
//     //final RemoteConfig remoteConfig = await RemoteConfig.instance;

//     try {
//       // Using default duration to force fetching from remote server.
//       await remoteConfig.ensureInitialized();
//       await remoteConfig.setConfigSettings(RemoteConfigSettings(
//         fetchTimeout: const Duration(minutes: 1),
//         minimumFetchInterval: const Duration(hours: 1),
//       ));
//       await remoteConfig.fetchAndActivate();
//       remoteConfig.getString('android_version');
//       double newVersion = double.parse(
//           remoteConfig.getString('android_version').trim().replaceAll(".", ""));
//       if (newVersion > currentVersion) {
//         _showVersionDialog(context);
//       }
//     } on FirebaseException catch (exception) {
//       // Fetch throttled.
//       log(exception.toString());
//     } catch (exception) {
//       log('Unable to fetch remote config. Cached or default values will be '
//           'used');
//     }
//   }

// //Show Dialog to force user to update
//   _showVersionDialog(context) async {
//     await showDialog<String>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         String title = "New Update Available";
//         String message =
//             "There is a newer version of app available please update it now.";
//         String btnLabel = "Update Now";
//         String btnLabelCancel = "Later";
//         return Platform.isIOS
//             ? CupertinoAlertDialog(
//                 title: Text(title),
//                 content: Text(message),
//                 actions: <Widget>[
//                   TextButton(
//                     child: Text(btnLabel),
//                     onPressed: () => _launchURL(APP_STORE_URL),
//                   ),
//                   TextButton(
//                     child: Text(btnLabelCancel),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ],
//               )
//             : AlertDialog(
//                 title: Text(title),
//                 content: Text(message),
//                 actions: <Widget>[
//                   TextButton(
//                     child: Text(btnLabel),
//                     onPressed: () => _launchURL(PLAY_STORE_URL),
//                   ),
//                   TextButton(
//                     child: Text(btnLabelCancel),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ],
//               );
//       },
//     );
//   }

//   _launchURL(String url) async {
//     if (await canLaunchUrl(Uri.parse(url))) {
//       await launchUrl(Uri.parse(url));
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }


// // import 'package:url_launcher/url_launcher.dart';

// // const APP_STORE_URL =
// //     'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=YOUR-APP-ID&mt=8';
// // const PLAY_STORE_URL =
// //     'https://play.google.com/store/apps/details?id=YOUR-APP-ID';

// // versionCheck(context) async {
// //   //Get Current installed version of app
// //   final PackageInfo info = await PackageInfo.fromPlatform();
// //   double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));

// //   //Get Latest version info from firebase config
// //   final RemoteConfig remoteConfig = await RemoteConfig.instance;

// //   try {
// //     // Using default duration to force fetching from remote server.
// //     await remoteConfig.fetch(expiration: const Duration(seconds: 0));
// //     await remoteConfig.activateFetched();
// //     remoteConfig.getString('force_update_current_version');
// //     double newVersion = double.parse(remoteConfig
// //         .getString('force_update_current_version')
// //         .trim()
// //         .replaceAll(".", ""));
// //     if (newVersion > currentVersion) {
// //       _showVersionDialog(context);
// //     }
// //   } on FetchThrottledException catch (exception) {
// //     // Fetch throttled.
// //     print(exception);
// //   } catch (exception) {
// //     print('Unable to fetch remote config. Cached or default values will be '
// //         'used');
// //   }
// // }
// // //Show Dialog to force user to update
// // _showVersionDialog(context) async {
// //   await showDialog<String>(
// //     context: context,
// //     barrierDismissible: false,
// //     builder: (BuildContext context) {
// //       String title = "New Update Available";
// //       String message =
// //           "There is a newer version of app available please update it now.";
// //       String btnLabel = "Update Now";
// //       String btnLabelCancel = "Later";
// //       return Platform.isIOS
// //           ? new CupertinoAlertDialog(
// //               title: Text(title),
// //               content: Text(message),
// //               actions: <Widget>[
// //                 FlatButton(
// //                   child: Text(btnLabel),
// //                   onPressed: () => _launchURL(Config.APP_STORE_URL),
// //                 ),
// //                 FlatButton(
// //                   child: Text(btnLabelCancel),
// //                   onPressed: () => Navigator.pop(context),
// //                 ),
// //               ],
// //             )
// //           : new AlertDialog(
// //               title: Text(title),
// //               content: Text(message),
// //               actions: <Widget>[
// //                 FlatButton(
// //                   child: Text(btnLabel),
// //                   onPressed: () => _launchURL(Config.PLAY_STORE_URL),
// //                 ),
// //                 FlatButton(
// //                   child: Text(btnLabelCancel),
// //                   onPressed: () => Navigator.pop(context),
// //                 ),
// //               ],
// //             );
// //     },
// //   );
// // }

// // _launchURL(String url) async {
// //   if (await canLaunch(url)) {
// //     await launch(url);
// //   } else {
// //     throw 'Could not launch $url';
// //   }
// // }

import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:force_update/update_screen.dart';
import 'package:package_info/package_info.dart';

import 'home_screen.dart';
import 'main.dart';

class CheckUpdate extends StatefulWidget {
   const CheckUpdate({super.key});

  @override
  State<CheckUpdate> createState() => _MyAppState();
}

class _MyAppState extends State<CheckUpdate> {

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
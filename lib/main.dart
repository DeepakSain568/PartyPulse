import 'package:newupdate/app/App/startapp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_app_check/firebase_app_check.dart';
import 'dart:developer';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

//    await FirebaseAppCheck.instance.activate(
//     //Use this site key in the HTML code your site serves to users.
// // 6Lc8rmgoAAAAALxmWiWbHrQoovZyYTIFIzy602-Q

// // Use this secret key for communication between your site and reCAPTCHA.
// // 6Lc8rmgoAAAAAIkXVhkCLTflBjeBj7VQ32_QW_sN
// // https://www.google.com/recaptcha/admin/site/677948988

//     webProvider: ReCaptchaV3Provider(' 6Lc8rmgoAAAAAIkXVhkCLTflBjeBj7VQ32_QW_sN'),
//     androidProvider: AndroidProvider.playIntegrity,
//   );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const StartApp();
  }
}

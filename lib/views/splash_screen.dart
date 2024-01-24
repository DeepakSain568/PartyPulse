// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:newupdate/viewmodels/splas_screen_service.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashservices = SplashServices();
  @override
  void initState() {
    super.initState();
    splashservices.isLogin(context);
    
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        "Splash Screen",
        style: TextStyle(
            color: Colors.grey, fontSize: 38, fontWeight: FontWeight.bold),
      )),
    );
  }
}

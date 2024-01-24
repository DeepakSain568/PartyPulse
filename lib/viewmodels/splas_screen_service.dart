import 'dart:async';
import 'package:flutter/material.dart';
import 'package:newupdate/app/firebaseservices/firebaseservices.dart';
import 'package:newupdate/utils/routing/routenames.dart';

import '../app/firebaseservices/firebasefirestore.dart';

class SplashServices {
  void isLogin(BuildContext context) async {
        // await  FireStoreDataBase().updateData();
    final user = Services.Authobject.currentUser;
    if (user != null) {
      print(user.uid);
      print("users email ${user.email}");
      await Future.delayed(const Duration(seconds: 1));
      Navigator.popAndPushNamed(context, RouteNames.homescreen,
          arguments: user.uid);
    } else {
      await Future.delayed(const Duration(seconds: 1));
      Navigator.popAndPushNamed(context, RouteNames.emailpasswordloginscreen);
    }
  }
}

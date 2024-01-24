import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newupdate/app/firebaseservices/firebasefirestore.dart';
import 'package:newupdate/utils/displaymessage.dart';
import 'package:newupdate/utils/routing/routenames.dart';
import '../../app/firebaseservices/firebaseservices.dart';

class Authentication {

  LoginWithEmailAndPassword(
      BuildContext context, String Email, String Password) async {
    print("email and password values");
    print(Email + Password);
    try {
      await Services.Authobject.signInWithEmailAndPassword(
          email: Email, password: Password);
      if (Services.Authobject.currentUser != null) {
        print(Services.Authobject.currentUser);
        Navigator.pushNamed(context, RouteNames.homescreen,
            arguments: Services.Authobject.currentUser!.uid.toString());
      }
    } catch (e) {
      print("login error $e");
      Utils.toastMessage(e.toString());
    }
  }

  GetPhoneAuthCredential(BuildContext context, String PhoneNumber) async {
    try {
      bool verification = await FireStoreDataBase().VerifyNumber(PhoneNumber);
      if (verification) {
        await Services.Authobject.verifyPhoneNumber(
            phoneNumber: '+91$PhoneNumber',
            verificationCompleted: (credential) async {
              await Services.Authobject.signInWithCredential(credential);
            },
            verificationFailed: (FirebaseAuthException error) {
              print(error.toString());
            },
            codeSent: (String verificationId, int? forceResendingToken) {
              Navigator.popAndPushNamed(context, RouteNames.otpscreen,
                  arguments: verificationId);
            },
            codeAutoRetrievalTimeout: (e) {
              print(e.toString());
            });
      } else {
        throw "PhoneNumber Not Registered";
      }
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
  }

  UserRegistration(String Email, String Password) async {
    try {
      await Services.Authobject.createUserWithEmailAndPassword(
              email: Email, password: Password)
          .timeout(const Duration(minutes: 1));
    } catch (e) {
      print("error");
      rethrow;
    }
  }


  ForgotPassword() async {}

  Future<void> LogOut(BuildContext context) async {
    try {
      await Services.Authobject.signOut();
      final user = Services.Authobject.currentUser;
      if (user == null) {
        Navigator.pushReplacementNamed(
            context, RouteNames.emailpasswordloginscreen);
        Utils.toastMessage("You are Logged Out");
      } else {
        Utils.toastMessage("Try Again");
      }
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
  }
}

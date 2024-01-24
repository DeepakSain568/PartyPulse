import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newupdate/app/data/modals/globalvariables.dart';
import 'package:newupdate/utils/widgets/widgets.dart';

import '../../../app/firebaseservices/firebaseservices.dart';
import '../../../utils/routing/routenames.dart';

PhoneAuthCredential Credentials(PhoneAuthCredential credential) {
  return credential;
}

class OTPVerificationScreen extends StatefulWidget {
  final String verificationId;
  const OTPVerificationScreen({super.key, required this.verificationId});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  TextEditingController otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Enter Your OTP"),
        textField(
            context: context,
            text: "6 digit Pin",
            icon: Icons.numbers,
            isPasswordType: false,
            isPhonetype: true,
            isEmailType: false,
            currentFocusNode: FocusNode(),
            NextFocusNode: FocusNode(),
            ValidationMessage: "Enter Valif OTP",
            controller: otp),
        const SizedBox(
          height: 5,
        ),
        ElevatedButton(
            onPressed: () async {
              try {
                // final credentials = PhoneAuthProvider.credential(
                //     verificationId: widget.verificationId,
                //     smsCode: otp.text);
                
                await Services.Authobject.signInWithCredential(
                    PhoneAuthProvider.credential(
                        verificationId: widget.verificationId,
                        smsCode: otp.text));
                    if (Services.Authobject.currentUser != null) {
                        Navigator.pushNamed(context, RouteNames.homescreen,
                            arguments:
                                Services.Authobject.currentUser!.uid);
                      }
                 print("Verification complete$OtpCredential");
                print("Verification complete");
              } catch (e) {
                print("error in otpverification screen$e");
                rethrow;
              }
            },
            child: const Text("Enter Otp"))
      ],
    ));
  }
}

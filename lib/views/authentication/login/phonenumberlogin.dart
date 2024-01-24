import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newupdate/utils/constants.dart';
import 'package:newupdate/utils/routing/routenames.dart';
import 'package:newupdate/utils/widgets/widgets.dart';
import 'package:newupdate/viewmodels/users/Authentication.dart';
import 'package:newupdate/viewmodels/users/duringlogin.dart';
import 'package:provider/provider.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController phoneNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumber.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
          body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          width: width,
          height: height,
          decoration: BoxDecoration(color: constants().backgroundThemeColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Generate OTP",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Add your phone number. we'll send you a verification code sp we know you're real",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              textField(
                  context: context,
                  text: "PhoneNumber",
                  icon: Icons.phone,
                  isPasswordType: false,
                  isPhonetype: true,
                  isEmailType: false,
                  currentFocusNode: FocusNode(),
                  NextFocusNode: FocusNode(),
                  ValidationMessage: "Enter Your Number",
                  controller: phoneNumber),
              Consumer<Loading>(
                  builder: (context, value, child) => SignInSignUpButton(
                          context, "Get Otp", value.GetOtpLoginLoading, () async {
                        value.SetOtpLoginLoading = true;
                        try {
                          await Authentication().GetPhoneAuthCredential(
                              context, phoneNumber.text);
                          print("go to");
                          value.SetOtpLoginLoading = false;
                        } catch (e) {
                          print("error during phone login $e");
                        }
                      }, _formKey)),
              textButton("Don't have an account?", () {
                Navigator.popAndPushNamed(context, RouteNames.registerscreen);
              }, "Create account"),
              textButton("Login with email and password ", () {
                Navigator.popAndPushNamed(
                    context, RouteNames.emailpasswordloginscreen);
              }, "Login")
            ],
          ),
        ),
      )),
    );
  }
}

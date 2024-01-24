import 'package:flutter/material.dart';
import 'package:newupdate/app/data/modals/globalvariables.dart';
import 'package:newupdate/utils/constants.dart';
import 'package:newupdate/utils/routing/routenames.dart';
import 'package:newupdate/utils/widgets/widgets.dart';
import 'package:newupdate/viewmodels/users/Authentication.dart';
import 'package:newupdate/viewmodels/users/duringlogin.dart';
import 'package:newupdate/viewmodels/users/registration.dart';
import 'package:provider/provider.dart';

import '../../../app/firebaseservices/firebaseservices.dart';

class EmailPasswordloginPage extends StatefulWidget {
  const EmailPasswordloginPage({super.key});

  @override
  State<EmailPasswordloginPage> createState() => _EmailPasswordloginPageState();
}

class _EmailPasswordloginPageState extends State<EmailPasswordloginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Authentication _authentication = Authentication();

  @override
  void initState() {
    email.addListener(() {
      print("The email is now :${email.text}");
    });
    password.addListener(() {
      print("The password is not ${password.text}");
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();

    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(255, 153, 51, 3),
        title: const Center(
          child: Text("Login",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
      ),
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(color: constants().backgroundThemeColor),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textField(
                  context: context,
                  text: "email",
                  icon: Icons.email,
                  isPasswordType: false,
                  isPhonetype: false,
                  isEmailType: true,
                  currentFocusNode: Registration().emailFocusNode,
                  NextFocusNode: Registration().passwordFocusNode,
                  ValidationMessage: "Enter Your Email",
                  controller: email),
              const SizedBox(
                height: 13,
              ),
              textField(
                  context: context,
                  text: "Password",
                  icon: Icons.lock,
                  isPasswordType: true,
                  isPhonetype: false,
                  isEmailType: false,
                  currentFocusNode: Registration().PhoneFocusNode,
                  NextFocusNode: FocusNode(),
                  ValidationMessage: "Enter Your Password",
                  controller: password),
              const SizedBox(
                height: 13,
              ),
              Consumer<Loading>(builder: (context, value, child) {
                return SignInSignUpButton(
                    context, "Login", value.GetEmailPasswordLoginLoading,
                    () async {
                  value.SetEmailPasswordLoginLoading = true;
                  await _authentication.LoginWithEmailAndPassword(
                      context, email.text, password.text);
                  value.SetEmailPasswordLoginLoading = false;
                  if (Services.Authobject.currentUser != null) {
                    CurrentUserIdentity = Services.Authobject.currentUser!.uid;
                    Navigator.pushNamed(context, RouteNames.homescreen,
                        arguments: Services.Authobject.currentUser!.uid);
                  }
                }, _formKey);
                // print("Built");
                // return Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: 50,
                //   margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                //   decoration:
                //       BoxDecoration(borderRadius: BorderRadius.circular(90)),
                //   child:
                //   ElevatedButton(
                //     style: ButtonStyle(
                //       backgroundColor:
                //           MaterialStateProperty.resolveWith((states) {
                //         if (states.contains(MaterialState.pressed)) {
                //           return Colors.black26;
                //         }
                //         return constants().Themecolor;
                //       }),
                //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //           RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(30))),
                //     ),
                //     onPressed: () async {
                //       if (_formKey.currentState!.validate()) {
                //         await _authentication.LoginWithEmailAndPassword(
                //             context, email.text, password.text);
                //         if (Services.Authobject.currentUser != null) {
                //           CurrentUserIdentity = Services.Authobject.currentUser!.uid;
                //           Navigator.pushNamed(context, RouteNames.homescreen,
                //               arguments: Services.Authobject.currentUser!.uid);
                //         }
                //       } else {
                //         Utils.toastMessage("Enter Valid Details");
                //       }
                //     },
                //     child: value.GetEmailPasswordLoginLoading
                //         ? CircularProgressIndicator(
                //             color: constants().backgroundThemeColor,
                //           )
                //         : const Text(
                //             "Login",
                //             style: TextStyle(
                //                 color: Colors.black87,
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.bold),
                //           ),
                //   ),
                // );
              }),

              textButton("Don't have an account?", () {
                Navigator.popAndPushNamed(context, RouteNames.registerscreen);
              }, "Create One"),
            ],
          ),
        ),
      ),
    );
  }
}

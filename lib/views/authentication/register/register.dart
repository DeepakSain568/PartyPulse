import 'package:flutter/material.dart';
import 'package:newupdate/utils/constants.dart';
import 'package:newupdate/utils/routing/routenames.dart';
import 'package:newupdate/utils/widgets/widgets.dart';
import 'package:newupdate/viewmodels/BackendManagement.dart';
import 'package:newupdate/viewmodels/users/duringlogin.dart';
import 'package:provider/provider.dart';

import '../../../app/data/modals/userdata.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController Password = TextEditingController();
  final countryCode = "+91";
  final BackendManagement _backendManagement = BackendManagement();
  String? State;
  String? District;
  String? Tehsil;
  String? Address;
  @override
  void dispose() {
    super.dispose();
    name.dispose();
    phoneNumber.dispose();
    email.dispose();
    Password.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeStates();
    State = null;
    District = null;
    Tehsil = null;
    Address = null;
  }

  void initializeStates() async {
    await _backendManagement.FetchStatesList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: constants().Themecolor,
        title: const Center(
          child: Text("Registration",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
      ),
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: constants().backgroundThemeColor),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textField(
                          context: context,
                          text: "name",
                          icon: Icons.person,
                          isPasswordType: false,
                          isPhonetype: false,
                          isEmailType: false,
                          currentFocusNode: FocusNode(),
                          NextFocusNode: FocusNode(),
                          ValidationMessage: "Enter Your Name",
                          controller: name),
                      const SizedBox(
                        height: 13,
                      ),
                      textField(
                          context: context,
                          text: "email",
                          icon: Icons.email,
                          isPasswordType: false,
                          isPhonetype: false,
                          isEmailType: true,
                          currentFocusNode: FocusNode(),
                          NextFocusNode: FocusNode(),
                          ValidationMessage: "Enter your Email",
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
                          currentFocusNode: FocusNode(),
                          NextFocusNode: FocusNode(),
                          ValidationMessage: "Enter Your Password",
                          controller: Password),
                      const SizedBox(
                        height: 13,
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
                      const SizedBox(
                        height: 13,
                      ),
                      DropDownList(
                          onSelecte: (Value) async {
                            State = Value;
                            await _backendManagement.FetchDistrictsList(State!);
                            Tehsil = null;
                            Address = null;
                            District = null;
                            setState(() {});
                          },
                          NewValue: State,
                          Locations:
                              _backendManagement.places.StatesList.isEmpty
                                  ? ["Goa"]
                                  : _backendManagement.places.StatesList,
                          Typename: "State",
                          iCon: Icons.place),
                      DropDownList(
                          onSelecte: (Value) async {
                            District = Value;
                            await _backendManagement.FetchTehsilsList(
                                State!, District!);
                            Address = null;
                            Tehsil = null;
                            setState(() {});
                          },
                          NewValue: District,
                          Locations: _backendManagement
                                  .places.CorrespondingDistrictsList.isEmpty
                              ? ["North Goa"]
                              : _backendManagement
                                  .places.CorrespondingDistrictsList,
                          Typename: "District",
                          iCon: Icons.place),
                      DropDownList(
                          onSelecte: (Value) async {
                            Tehsil = Value;

                            await _backendManagement.FetchAddressList(
                                State!, District!, Tehsil!);
                            Address = null;
                            setState(() {});
                          },
                          NewValue: Tehsil,
                          Locations:
                              _backendManagement.places.TehsilsList.isEmpty
                                  ? ["Tehsil1"]
                                  : _backendManagement.places.TehsilsList,
                          Typename: "Tehsil",
                          iCon: Icons.location_city),
                      DropDownList(
                          onSelecte: (Value) async {
                            Address = Value;
                            setState(() {});
                          },
                          NewValue: Address,
                          Locations:
                              _backendManagement.places.AddressesList.isEmpty
                                  ? ["Ward1"]
                                  : _backendManagement.places.AddressesList,
                          Typename: "Ward",
                          iCon: Icons.location_city_outlined),
                      Consumer<Loading>(
                          builder: (context, value, child) =>
                              SignInSignUpButton(
                                  context, "SignUp", value.GetSignupLoading,
                                  () async {
                                value.SetSignupLoading = true;
                                print(
                                    "$State+$District+$Address+$Tehsil");
                                await _backendManagement.SignUP(
                                    context,
                                    UserData(
                                        Name: name.text,
                                        Email: email.text,
                                        Password: Password.text,
                                        PhoneNumber: phoneNumber.text,
                                        State: State,
                                        District: District,
                                        Tehsil: Tehsil,
                                        Address: Address,
                                        Status: status.NoValue.toString(),
                                        UserID: ""
                                        ));
                                value.SetSignupLoading = false;
                              }, _formKey)),
                      textButton("Already have an acccount?", () {
                        Navigator.popAndPushNamed(
                            context, RouteNames.loginscreen);
                      }, "Login")
                    ],
                  )
                  // }),
                  )),
        ),
      ),
    );
  }
}

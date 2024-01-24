import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newupdate/utils/constants.dart';
import 'package:newupdate/utils/displaymessage.dart';
import 'package:newupdate/viewmodels/BackendManagement.dart';
import 'package:newupdate/viewmodels/adminsviewmodal/AdminViewModal.dart';
import 'package:newupdate/viewmodels/menubuttons.dart';
import 'package:newupdate/viewmodels/users/Authentication.dart';
import 'package:newupdate/viewmodels/users/registration.dart';
import '../../app/data/modals/globalvariables.dart';
import '../../app/data/modals/userdata.dart';

Widget DropDownList(
    {required Locations,
    required Typename,
    required iCon,
    required NewValue,
    required onSelecte}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: DropdownButtonFormField<String>(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Select the Field";
          }
          return null;
        },
        decoration: InputDecoration(
          fillColor: constants().FieldsColor,
          prefixIcon: Icon(
            iCon,
            color: Colors.black87,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        hint: Text(Typename),
        value: NewValue,
        onChanged: (value) async {
          NewValue = value!;
          await onSelecte(value);
        },
        icon: const Icon(Icons.arrow_drop_down),
        items: Locations.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    ),
  );
}

SignInSignUpButton(BuildContext context, String ButtonMessage, bool isloading,
    Function onTap, GlobalKey<FormState> formKey) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black26;
          }
          return constants().Themecolor;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      ),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          await onTap();
        } else {
          Utils.toastMessage("Enter Valid Details");
        }
      },
      child: isloading
          ? CircularProgressIndicator(
              color: constants().backgroundThemeColor,
            )
          : Text(
              ButtonMessage,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
    ),
  );
}

Row textButton(String buttonMessage, Function onTap, String buttonNmae) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        buttonMessage,
        style: const TextStyle(
            color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w400),
      ),
      TextButton(
        onPressed: () {
          onTap();
        },
        child: Text(
          buttonNmae,
          style: TextStyle(
              color: constants().Themecolor,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      )
    ],
  );
}

class textField extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isPasswordType;
  final bool isPhonetype;
  final bool isEmailType;
  final FocusNode currentFocusNode;
  final FocusNode NextFocusNode;
  final String ValidationMessage;
  final TextEditingController controller;
  const textField(
      {super.key,
      required BuildContext context,
      required this.text,
      required this.icon,
      required this.isPasswordType,
      required this.isPhonetype,
      required this.isEmailType,
      required this.currentFocusNode,
      required this.NextFocusNode,
      required this.ValidationMessage,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: currentFocusNode,
      onFieldSubmitted: (value) {
        Registration()
            .FieldFocusChange(context, currentFocusNode, currentFocusNode);
      },
      obscureText: isPasswordType,
      controller: controller,
      enableSuggestions: isPhonetype,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black.withOpacity(0.9)),
      decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black87,
          ),
          fillColor: constants().FieldsColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1, style: BorderStyle.none)),
          labelText: text,
          labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never),
      keyboardType: isPhonetype ? TextInputType.phone : TextInputType.name,
      // autovalidateMode: AutovalidateMode.always,
      validator: (value) {
        if (value!.isEmpty) {
          return ValidationMessage;
        } else if (isEmailType) {
          final RegExp emailRegex =
              RegExp(r'[a-z0-9._%+-]+@[a-z.-]+\.[a-z]{2,4}$');
          if (!emailRegex.hasMatch(value)) {
            return "Enter Valid Email Address";
          }
        } else if (isPasswordType) {
          RegExp passwordRegExp = RegExp(
              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=!])(?=.*[a-zA-Z\d@#$%^&+=!]).{8,}$');
          if (!passwordRegExp.hasMatch(value)) {
            return '''1. At least 8 characters long.
                    2. Contains both lowercase and uppercase letters.
                    3. Contains at least one digit .
                    4. Contains at least one special character (e.g., @, #, \$, %, etc.).'''
                .padLeft(5);
          }
        }
        return null;
      },
    );
  }
}

Container listTile(BuildContext context, String title, Function onTap) {
  return Container(
      height: 55,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black45,
                blurStyle: BlurStyle.inner,
                blurRadius: 4,
                offset: Offset(0.8, 1.2))
          ]),
      child: Center(
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          trailing: InkWell(
              onTap: () {
                onTap();
              },
              child: const Icon(Icons.arrow_forward_ios_rounded)),
          shape: const BeveledRectangleBorder(
            side: BorderSide(width: 1, color: Colors.black),
          ),
        ),
      ));
}

class MenuSideBar extends StatefulWidget {
  final String UserId;
  const MenuSideBar({super.key, required this.UserId});

  @override
  State<MenuSideBar> createState() => _MenuSideBarState();
}

class _MenuSideBarState extends State<MenuSideBar> {
  final BackendManagement _backendManagement = BackendManagement();
  final AdminViewModal _adminViewModal = AdminViewModal();

  @override
  void initState() {
  
    super.initState();
    IDVerification();
  }

  IDVerification() async {
    await _adminViewModal.IsAdmin(widget.UserId);
    Future.delayed(const Duration(seconds: 40));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: StreamBuilder<DocumentSnapshot<UserData>>(
            stream: _backendManagement.FetchUserData(widget.UserId),
            builder:
                (context, AsyncSnapshot<DocumentSnapshot<UserData>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: constants().Themecolor,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(
                  snapshot.error.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                );
              } else if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(
                    child: Text("User Not Found",
                        style: TextStyle(color: Colors.black, fontSize: 20)));
              }
              UserData userData = snapshot.data!.data()!;
              return Column(
                  children: List<Widget>.from([
                StreamBuilder<bool>(
                  stream: _adminViewModal.generalAdminStream,
                  initialData: _adminViewModal.GeneralAdmin,
                  builder: (context, snapshot) {
                    final generalAdmin = snapshot.data ?? false;
                    return UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: constants().Themecolor),
                      accountName: generalAdmin
                          ? Text(_adminViewModal.GetAdminsData.Id.toString())
                          : Text(userData.Name.toString()),
                      //  Consumer<AdminViewModal>( builder: (context, value, child) =>
                      // value.GeneralAdmin
                      //     ? Text(value.GetAdminsData.Id.toString())
                      //     : Text(userData.Name.toString()),),
                      accountEmail: Text(userData.Email.toString()),
                      currentAccountPicture: CircleAvatar(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox(
                                width: 130,
                                height: 130,
                                child: IMAGE != null
                                    ? Image(
                                        image: FileImage(IMAGE!),
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: constants().Themecolor,
                                            ),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Center(
                                              child: Icon(Icons.error));
                                        },
                                        fit: BoxFit.cover,
                                      )
                                    : const ColoredBox(color: Colors.white))),
                      ),
                    );
                  },
                ),
                ListTile(
                  onTap: () async {
                    if (await _adminViewModal.IsAdmin(widget.UserId) &&
                        _adminViewModal.IsMainAdmin) {
                      MenuButtons().AdminAssign(context);
                    } else {
                      Utils.toastMessage(" Super Admin Can Acces This");
                    }
                  },
                  leading: const Icon(Icons.admin_panel_settings),
                  title: const Text("Assign Admin Positions"),
                ),
                ListTile(
                  onTap: () {
                    MenuButtons().UserProfile(context, widget.UserId);
                  },
                  leading: const Icon(Icons.person),
                  title: const Text("UserProfile"),
                ),
                ListTile(
                  onTap: () => _adminViewModal.AdminVerification(() {
                    MenuButtons().Meetings(context);
                  }, widget.UserId, "Admins Only Arrange Meetings"),
                  leading: const Icon(Icons.meeting_room),
                  title: const Text("Meetings"),
                ),
                ListTile(
                  onTap: () => Authentication().LogOut(context),
                  leading: const Icon(Icons.logout),
                  title: const Text("LogOut"),
                )
              ]));
            }));
  }
}

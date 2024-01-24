import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newupdate/app/data/modals/userdata.dart';
import 'package:newupdate/utils/constants.dart';
import 'package:newupdate/utils/widgets/profilewidgets.dart';
import 'package:newupdate/viewmodels/BackendManagement.dart';
import 'package:newupdate/viewmodels/adminsviewmodal/AdminViewModal.dart';
import 'package:newupdate/viewmodels/userprofile/profileviewmodal.dart';
import 'package:newupdate/viewmodels/users/Authentication.dart';
import 'package:provider/provider.dart';

import '../../app/data/modals/globalvariables.dart';

class UserProfile extends StatefulWidget {
  final String UserID;
  const UserProfile({super.key, required this.UserID});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final BackendManagement _backendManagement = BackendManagement();
  final Authentication _authentication = Authentication();
  final AdminViewModal _adminViewModal = AdminViewModal();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IDVerification();
  }

  IDVerification() async {
    await _adminViewModal.IsAdmin(widget.UserID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        color: constants().backgroundThemeColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<DocumentSnapshot<UserData>>(
            stream: _backendManagement.FetchUserData(widget.UserID),
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
              return Column(children: [
                const SizedBox(
                  height: 55,
                ),
                Consumer<ProfileViewModal>(
                  builder: (context, value, child) => Row(
                    children: [
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: constants().Themecolor),
                            shape: BoxShape.circle),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child:
                                // userData.ProfileImageUrl == null?
                                SizedBox(
                                    width: 130,
                                    height: 130,
                                    child: IMAGE != null
                                        // userData.ProfileImageUrl != null
                                        ? Image(
                                            image: FileImage(IMAGE!),
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: constants().Themecolor,
                                                ),
                                              );
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              print(error);
                                              return const Center(
                                                  child: Icon(Icons.error));
                                            },
                                            fit: BoxFit.cover,
                                          )
                                        : const ColoredBox(color: Colors.white))),
                      ),
                      InkWell(
                        onTap: () async {
                          File? selectedImage = await value.SelectImage();
                          print(
                              "image paramter value before selection verification $IMAGE");
                          if (selectedImage != null) {
                            // IMAGE = selectedImage;
                            print(
                                "image paramter value after selection verification $IMAGE");

                            _backendManagement.UploadProfileImage(
                                userData.UserID, selectedImage);
                          }
                        },
                        child: const Icon(
                            size: 20,
                            shadows: [
                              BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(-1, 2),
                                  blurRadius: 15,
                                  spreadRadius: 60,
                                  blurStyle: BlurStyle.outer)
                            ],
                            Icons.edit),
                      ),
                      StreamBuilder<bool>(
                      stream: _adminViewModal.generalAdminStream, 
                      initialData: _adminViewModal.GeneralAdmin, 
                      builder: (context, snapshot) {
                        final generalAdmin = snapshot.data ?? false;
                      return Padding(
                            padding: const EdgeInsets.only(top: 25, left: 0),
                            child: generalAdmin
                                ? const CircleAvatar(
                                    maxRadius: 7.5,
                                    backgroundColor: Colors.green,
                                  )
                                : CircleAvatar(
                                    maxRadius: 0,
                                    backgroundColor:
                                        constants().backgroundThemeColor,
                                  ));
                }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Consumer<ProfileViewModal>(builder: (context, value, child) {
                  if (value.Name) {
                    return UserInfoTile(context, userData.Name.toString(), () {
                      value.NameField = false;
                    }, Icons.person);
                  } else {
                    return Form(
                      key: _formKey,
                      child: ProfileInputField(context, _formKey, () async {
                        try {
                          _backendManagement.UpdateUserValues(
                              UserId: widget.UserID,
                              Field: "Name",
                              Value: _name.text);
                        } catch (e) {
                          rethrow;
                        }
                        value.NameField = true;
                      }, Icons.person, _name),
                    );
                  }
                }),
                const SizedBox(
                  height: 35,
                ),
                Consumer<ProfileViewModal>(builder: (context, value, child) {
                  print("built");
                  if (value.Email) {
                    return UserInfoTile(
                        context, snapshot.data!.data()!.Email.toString(), () {
                      value.EmailField = false;
                    }, Icons.email);
                  } else {
                    return Form(
                      key: _formKey,
                      child: ProfileInputField(context, _formKey, () async {
                        try {
                          _backendManagement.UpdateUserValues(
                              UserId: widget.UserID,
                              Field: "Email",
                              Value: _email.text);
                        } catch (e) {
                          rethrow;
                        }
                        value.EmailField = true;
                      }, Icons.email, _email),
                    );
                  }
                }),
                const SizedBox(
                  height: 35,
                ),
                Consumer<ProfileViewModal>(builder: (context, value, child) {
                  if (value.Number) {
                    return UserInfoTile(
                        context, userData.PhoneNumber.toString(), () {
                      value.NumberField = false;
                    }, Icons.phone);
                  } else {
                    return Form(
                      key: _formKey,
                      child: ProfileInputField(context, _formKey, () async {
                        try {
                          await _authentication.GetPhoneAuthCredential(
                              context, _number.text);
                          await _backendManagement.UpdateUserValues(
                              UserId: widget.UserID,
                              Field: "PhoneNumber",
                              Value: _number.text);
                        } catch (e) {
                          rethrow;
                        }
                        value.NumberField = true;
                      }, Icons.phone, _number),
                    );
                  }
                })
              ]);
            }),
      ),
    );
  }
}

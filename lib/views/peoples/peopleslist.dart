import 'package:flutter/material.dart';
import 'package:newupdate/app/data/modals/globalvariables.dart';
import 'package:newupdate/utils/constants.dart';
import 'package:newupdate/utils/routing/routenames.dart';
import 'package:newupdate/utils/widgets/peoplesWidgets/radiobutton.dart';
import 'package:newupdate/viewmodels/BackendManagement.dart';
import 'package:newupdate/viewmodels/adminsviewmodal/AdminViewModal.dart';

import '../../utils/displaymessage.dart';

class peoplesPage extends StatefulWidget {
  final Map peoples;
  const peoplesPage({super.key, required this.peoples});

  @override
  State<peoplesPage> createState() => _peoplesPageState();
}

class _peoplesPageState extends State<peoplesPage> {
  final BackendManagement _backendManagement = BackendManagement();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteNames.CreateUserScreen);
        },
        backgroundColor: constants().Themecolor,
        focusColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 35,
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: constants().Themecolor,
        title: const Center(child: Text("PeoplesList")),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                    child: ListTile(
                  leading: const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.green,
                  ),
                  title: const Text("Present"),
                  onTap: () async {
                    await _backendManagement.PresentUsers(
                        widget.peoples["state"],
                        widget.peoples["district"],
                        widget.peoples["tehsil"],
                        widget.peoples["address"]);

                    Navigator.pushNamed(
                      context,
                      RouteNames.presentpeoplescreen,
                      arguments: _backendManagement.usersData.PresentUsers,
                    );
                  },
                )),
                PopupMenuItem(
                    child: ListTile(
                  leading: const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.yellow,
                  ),
                  title: const Text("Waiting"),
                  onTap: () async {
                    await _backendManagement.HalPresentUsers(
                        widget.peoples["state"],
                        widget.peoples["district"],
                        widget.peoples["tehsil"],
                        widget.peoples["address"]);
                    Navigator.pushNamed(
                      context,
                      RouteNames.halfpresentpeoplescreen,
                      arguments: _backendManagement.usersData.HalfPresentUsers,
                    );
                  },
                )),
                PopupMenuItem(
                    child: ListTile(
                  leading: const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.red,
                  ),
                  title: const Text("Absent"),
                  onTap: () async {
                    await _backendManagement.AbsentUsers(
                        widget.peoples["state"],
                        widget.peoples["district"],
                        widget.peoples["tehsil"],
                        widget.peoples["address"]);
                    Navigator.pushNamed(
                      context,
                      RouteNames.abseentpeoplescreen,
                      arguments: _backendManagement.usersData.AbsentUsers,
                    );
                  },
                ))
              ];
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: constants().backgroundThemeColor),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            FutureBuilder(
                future: _backendManagement.AddressLevelUsers(
                    widget.peoples["state"],
                    widget.peoples["district"],
                    widget.peoples["tehsil"],
                    widget.peoples["address"]),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator(
                      color: constants().Themecolor,
                    );
                  } else {
                    return Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.only(left: 7, right: 7),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount:
                            _backendManagement.usersData.UsersonAddress.length,
                        itemBuilder: (context, index) {
                          return Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
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
                                  leading: RadioButton(
                                      context,
                                      _backendManagement
                                          .usersData
                                          .UsersonAddress[index]
                                          .Status, (value) async {
                                    if (await AdminViewModal()
                                        .IsAdmin(CurrentUserIdentity)) {
                                      await _backendManagement.MarkAttendance(
                                          _backendManagement.usersData
                                              .UsersonAddress[index].UserID,
                                          value);
                                      setState(() {});
                                    } else {
                                      Utils.toastMessage(
                                          "Admins Only Mark Attendance");
                                    }
                                  }),
                                  title: Text(
                                    _backendManagement
                                        .usersData.UsersonAddress[index].Name
                                        .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  shape: const BeveledRectangleBorder(
                                    side: BorderSide(
                                        width: 1, color: Colors.black),
                                  ),
                                ),
                              ));
                        },
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          color: constants().Themecolor,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 37,
                decoration: BoxDecoration(shape:BoxShape.circle,border: Border.all(width: 1,color: Colors.black)),
                child: IconButton(
                  onPressed: () {
                    AdminViewModal().AdminVerification(() async {
                      Navigator.pushNamed(context, RouteNames.Pdfscreen,
                          arguments: {
                            "List": _backendManagement.usersData.UsersonAddress,
                            "fileName": widget.peoples["state"]
                          });
                    }, CurrentUserIdentity, "Admins only download PDF");
                  },
                  icon: const Icon(
                    Icons.share_sharp,
                    color: Colors.black,
                    size: 20,
                  ),
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 25,
              ),
            ],
          )),
    );
  }
}

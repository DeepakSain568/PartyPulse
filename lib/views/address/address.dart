import 'package:flutter/material.dart';
import 'package:newupdate/app/data/modals/globalvariables.dart';
import 'package:newupdate/utils/constants.dart';
import 'package:newupdate/utils/routing/routenames.dart';
import 'package:newupdate/utils/widgets/widgets.dart';
import 'package:newupdate/viewmodels/BackendManagement.dart';
import 'package:newupdate/viewmodels/adminsviewmodal/AdminViewModal.dart';

class Addresses extends StatefulWidget {
  final Map address;
  const Addresses({super.key, required this.address});

  @override
  State<Addresses> createState() => _AddressesState();
}

class _AddressesState extends State<Addresses> {
  final BackendManagement _backendManagement = BackendManagement();

  @override
  Widget build(BuildContext context) {
    // List addresses = locations().addressList(widget.address["state"],widget.address["district"], widget.address["tehsil"]);
    return Scaffold(
      floatingActionButton: CircleAvatar(
        radius: 25,
        backgroundColor: constants().Themecolor,
        child: IconButton(
          onPressed: () async {
            AdminViewModal().AdminVerification(() async {
              await _backendManagement.TehsilLevelUsers(widget.address["state"],
                  widget.address["district"], widget.address["tehsil"]);
              Navigator.pushNamed(context, RouteNames.Pdfscreen, arguments: {
                "List": _backendManagement.usersData.UsersInTehsil,
               "fileName": widget.address["state"]
              });
            }, CurrentUserIdentity, "Admins only download PDF");
          },
          icon: const Icon(Icons.share_sharp),
          color: Colors.black,
          iconSize: 30,
        ),
      ),
      appBar: AppBar(
        title: Text(widget.address["tehsil"]),
        centerTitle: true,
        elevation: 0,
        backgroundColor: constants().Themecolor,
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
                    await _backendManagement
                        .FetchTehsilLevelAttendanceTypeUsers(
                            widget.address["state"],
                            widget.address["district"],
                            widget.address["tehsil"],
                            status.Present.toString());
                    Navigator.pushNamed(
                      context,
                      RouteNames.presentpeoplescreen,
                      arguments:
                          _backendManagement.usersData.TehsilPresentUsers,
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
                    await _backendManagement
                        .FetchTehsilLevelAttendanceTypeUsers(
                            widget.address["state"],
                            widget.address["district"],
                            widget.address["tehsil"],
                            status.Waiting.toString());
                    Navigator.pushNamed(
                      context,
                      RouteNames.halfpresentpeoplescreen,
                      arguments:
                          _backendManagement.usersData.TehsilHalfPresentUsers,
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
                    await _backendManagement
                        .FetchTehsilLevelAttendanceTypeUsers(
                            widget.address["state"],
                            widget.address["district"],
                            widget.address["tehsil"],
                            status.Absent.toString());
                    Navigator.pushNamed(
                      context,
                      RouteNames.abseentpeoplescreen,
                      arguments: _backendManagement.usersData.TehsilAbsentUsers,
                    );
                  },
                ))
              ];
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.amber[50]),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            FutureBuilder(
                future: _backendManagement.FetchAddressList(
                    widget.address["state"],
                    widget.address["district"],
                    widget.address["tehsil"]),
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
                            _backendManagement.places.AddressesList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, RouteNames.peoplescreen,
                                arguments: {
                                  "state": widget.address["state"],
                                  "district": widget.address["district"],
                                  "tehsil": widget.address["tehsil"],
                                  "address": _backendManagement
                                      .places.AddressesList[index]
                                }),
                            child: listTile(context,
                                _backendManagement.places.AddressesList[index],
                                () {
                              Navigator.pushNamed(
                                  context, RouteNames.peoplescreen,
                                  arguments: {
                                    "state": widget.address["state"],
                                    "district": widget.address["district"],
                                    "tehsil": widget.address["tehsil"],
                                    "address": _backendManagement
                                        .places.AddressesList[index]
                                  });
                            }),
                          );
                        },
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

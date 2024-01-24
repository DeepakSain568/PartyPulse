import 'package:flutter/material.dart';
import 'package:newupdate/app/data/modals/globalvariables.dart';
import 'package:newupdate/utils/constants.dart';
import 'package:newupdate/utils/routing/routenames.dart';
import 'package:newupdate/utils/widgets/widgets.dart';
import 'package:newupdate/viewmodels/BackendManagement.dart';
import 'package:newupdate/viewmodels/adminsviewmodal/AdminViewModal.dart';

class tehsilsPage extends StatefulWidget {
  final Map tehsilData;
  const tehsilsPage({super.key, required this.tehsilData});

  @override
  State<tehsilsPage> createState() => _tehsilsPageState();
}

class _tehsilsPageState extends State<tehsilsPage> {
  final BackendManagement _backendManagement = BackendManagement();
  @override
  Widget build(BuildContext context) {
    // List tehsils = locations()
    //     .tehsilsList(widget.tehsilData["state"], widget.tehsilData["district"]);
    return Scaffold(
      floatingActionButton: CircleAvatar(
        radius: 25,
        backgroundColor: constants().Themecolor,
        child: IconButton(
          onPressed: () async {
            AdminViewModal().AdminVerification(() async {
              await _backendManagement.DistrictLevelUsers(
                  widget.tehsilData["state"], widget.tehsilData["district"]);
              Navigator.pushNamed(context, RouteNames.Pdfscreen, arguments: {
                "List": _backendManagement.usersData.UsersInDistrict,
                 "fileName": widget.tehsilData["state"]
              });
            }, CurrentUserIdentity, "Admins only download PDF");
          },
          icon: const Icon(Icons.share_sharp),
          color: Colors.black,
          iconSize: 30,
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: constants().Themecolor,
        title:  Center(child: Text(widget.tehsilData["district"])),
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
                        .FetchDistrictLevelAttendanceTypeUsers(
                            widget.tehsilData["state"],
                            widget.tehsilData["district"],
                            status.Present.toString());
                    Navigator.pushNamed(
                      context,
                      RouteNames.presentpeoplescreen,
                      arguments:
                          _backendManagement.usersData.DistrictPresentUsers,
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
                        .FetchDistrictLevelAttendanceTypeUsers(
                            widget.tehsilData["state"],
                            widget.tehsilData["district"],
                            status.Waiting.toString());
                    Navigator.pushNamed(
                      context,
                      RouteNames.halfpresentpeoplescreen,
                      arguments:
                          _backendManagement.usersData.DistrictHalfPresentUsers,
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
                        .FetchDistrictLevelAttendanceTypeUsers(
                            widget.tehsilData["state"],
                            widget.tehsilData["district"],
                            status.Absent.toString());
                    Navigator.pushNamed(
                      context,
                      RouteNames.abseentpeoplescreen,
                      arguments:
                          _backendManagement.usersData.DistrictAbsentUsers,
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
                future: _backendManagement.FetchTehsilsList(
                    widget.tehsilData["state"], widget.tehsilData["district"]),
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
                        itemCount: _backendManagement.places.TehsilsList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, RouteNames.addresscreen,
                                arguments: {
                                  "state": widget.tehsilData["state"],
                                  "district": widget.tehsilData["district"],
                                  "tehsil": _backendManagement
                                      .places.TehsilsList[index]
                                }),
                            child: listTile(context,
                                _backendManagement.places.TehsilsList[index],
                                () {
                              Navigator.pushNamed(
                                  context, RouteNames.addresscreen,
                                  arguments: {
                                    "state": widget.tehsilData["state"],
                                    "district": widget.tehsilData["district"],
                                    "tehsil": _backendManagement
                                        .places.TehsilsList[index]
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

import 'package:flutter/material.dart';
import 'package:newupdate/app/data/modals/globalvariables.dart';
import 'package:newupdate/utils/constants.dart';
import 'package:newupdate/utils/routing/routenames.dart';
import 'package:newupdate/utils/widgets/widgets.dart';
import 'package:newupdate/viewmodels/BackendManagement.dart';
import 'package:newupdate/viewmodels/adminsviewmodal/AdminViewModal.dart';

class Districts extends StatefulWidget {
  final String state;
  const Districts({super.key, required this.state});

  @override
  State<Districts> createState() => _DistrictsState();
}

class _DistrictsState extends State<Districts> {
  final BackendManagement _backendManagement = BackendManagement();

  @override
  Widget build(BuildContext context) {
    // final List DistrictsList = locations().districtsList(widget.state);
    return Scaffold(
      floatingActionButton: CircleAvatar(
        radius: 25,
        backgroundColor: constants().Themecolor,
        child: IconButton(
          onPressed: () async {
            AdminViewModal().AdminVerification(() async {
              await _backendManagement.StateLevelUsers(widget.state);
              Navigator.pushNamed(context, RouteNames.Pdfscreen, arguments: {
                "List": _backendManagement.usersData.UsersInState,
                 "fileName": widget.state
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
        title: Center(child: Text(widget.state)),
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
                    await _backendManagement.FetchStateLevelAttendanceTypeUsers(
                        widget.state, status.Present.toString());
                    Navigator.pushNamed(
                      context,
                      RouteNames.presentpeoplescreen,
                      arguments: _backendManagement.usersData.StatePresentUsers,
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
                    await _backendManagement.FetchStateLevelAttendanceTypeUsers(
                        widget.state, status.Waiting.toString());
                    Navigator.pushNamed(
                      context,
                      RouteNames.halfpresentpeoplescreen,
                      arguments:
                          _backendManagement.usersData.StateHalfPresentUsers,
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
                    await _backendManagement.FetchStateLevelAttendanceTypeUsers(
                        widget.state, status.Absent.toString());
                    Navigator.pushNamed(
                      context,
                      RouteNames.abseentpeoplescreen,
                      arguments: _backendManagement.usersData.StateAbsentUsers,
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
                future: _backendManagement.FetchDistrictsList(widget.state),
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
                        itemCount: _backendManagement
                            .places.CorrespondingDistrictsList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, RouteNames.tehsilssscreen,
                                arguments: {
                                  "state": widget.state,
                                  "district": _backendManagement
                                      .places.CorrespondingDistrictsList[index]
                                }),
                            child: listTile(
                                context,
                                _backendManagement.places
                                    .CorrespondingDistrictsList[index], () {
                              Navigator.pushNamed(
                                  context, RouteNames.tehsilssscreen,
                                  arguments: {
                                    "state": widget.state,
                                    "district": _backendManagement.places
                                        .CorrespondingDistrictsList[index]
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

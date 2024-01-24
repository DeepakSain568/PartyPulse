import 'package:flutter/material.dart';
import 'package:newupdate/app/firebaseservices/firebasefirestore.dart';
import 'package:newupdate/utils/constants.dart';
import 'package:newupdate/utils/routing/routenames.dart';
import 'package:newupdate/utils/widgets/widgets.dart';
import 'package:newupdate/viewmodels/BackendManagement.dart';
import 'package:newupdate/viewmodels/adminsviewmodal/AdminViewModal.dart';

class HomePage extends StatefulWidget {
  final String UserId;
  const HomePage({super.key, required this.UserId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BackendManagement _backendManagement = BackendManagement();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleAvatar(
        radius: 25,
        backgroundColor: constants().Themecolor,
        child: IconButton(
          onPressed: () async {
            AdminViewModal().AdminVerification(() async {
              await _backendManagement.indiaLevelUsers();
              Navigator.pushNamed(context, RouteNames.Pdfscreen, arguments: {
                "List": _backendManagement.usersData.IndiaLevelUsers,
                "fileName": "All Over India"
              });
            }, widget.UserId, "Admins only download PDF");
          },
          icon: const Icon(Icons.share_sharp),
          color: Colors.black,
          iconSize: 30,
        ),
      ),
      drawer: MenuSideBar(UserId: widget.UserId),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppBar(
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
                        await _backendManagement.AttendanceTypeUsersLisTT(
                            status.Present.toString());
                        Navigator.pushNamed(
                          context,
                          RouteNames.presentpeoplescreen,
                          arguments:
                              _backendManagement.usersData.IndiaPresentUsers,
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
                        await _backendManagement.AttendanceTypeUsersLisTT(
                            status.Waiting.toString());
                        Navigator.pushNamed(
                          context,
                          RouteNames.halfpresentpeoplescreen,
                          arguments: _backendManagement
                              .usersData.IndiaHalfPresentUsers,
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
                        await _backendManagement.AttendanceTypeUsersLisTT(
                            status.Absent.toString());
                        Navigator.pushNamed(
                          context,
                          RouteNames.abseentpeoplescreen,
                          arguments:
                              _backendManagement.usersData.IndiaAbsentUsers,
                        );
                      },
                    ))
                  ];
                },
              )
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: constants().backgroundThemeColor),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 110,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 300),
              child: Text(
                "States",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: _backendManagement.FetchStatesList(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                          color: constants().backgroundThemeColor),
                    );
                  } else {
                    return Expanded(
                      child: ListView.separated(
                        padding:
                            const EdgeInsets.only(top: 9, left: 7, right: 7),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: _backendManagement.places.StatesList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, RouteNames.districtsscreen,
                                arguments: _backendManagement
                                    .places.StatesList[index]),
                            child: listTile(context,
                                _backendManagement.places.StatesList[index],
                                () {
                              Navigator.pushNamed(
                                  context, RouteNames.districtsscreen,
                                  arguments: _backendManagement
                                      .places.StatesList[index]);
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

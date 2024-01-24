import 'package:flutter/material.dart';
import 'package:newupdate/utils/constants.dart';
import '../../../viewmodels/BackendManagement.dart';

class meetingsList extends StatefulWidget {
  const meetingsList({super.key});

  @override
  State<meetingsList> createState() => _meetingsListState();
}

class _meetingsListState extends State<meetingsList> {
  final BackendManagement _backendManagement = BackendManagement();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: constants().backgroundThemeColor),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 17,
            ),
            FutureBuilder(
                future: _backendManagement.MeetingsList(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    // print(
                    // _backendManagement.meetingsData.GetMeetingsList()[0].Title);
                    return Center(
                      child: CircularProgressIndicator(
                    color: constants().Themecolor,
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.only(left: 7, right: 7),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: _backendManagement.meetingsData
                            .GetMeetingsList()
                            .length,
                        itemBuilder: (context, index) {
                          return Container(
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
                                    leading: Text(
                                      _backendManagement.meetingsData
                                          .GetMeetingsList()[index]
                                          .Title!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    ),
                                    subtitle: Text(
                                      _backendManagement.meetingsData
                                          .GetMeetingsList()[index]
                                          .Description!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15),
                                    )
                                    // trailing: InkWell(
                                    //     onTap: () {
                                    //       onTap();
                                    //     },
                                    //     child: const Icon(Icons.arrow_forward_ios_rounded)),
                                    // shape: const BeveledRectangleBorder(
                                    //   side: BorderSide(width: 1, color: Colors.black),
                                    // ),
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
    );
  }
}

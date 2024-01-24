import 'package:flutter/material.dart';
import 'package:newupdate/utils/constants.dart';
import 'package:newupdate/utils/routing/routenames.dart';
import 'package:newupdate/utils/widgets/peoplesWidgets/attendanceshowtile.dart';

import '../../app/data/modals/globalvariables.dart';
import '../../viewmodels/adminsviewmodal/AdminViewModal.dart';

class AbsenteesList extends StatefulWidget {
  final List AbsentesList;
  const AbsenteesList({super.key, required this.AbsentesList});

  @override
  State<AbsenteesList> createState() => _AbsenteesListState();
}

class _AbsenteesListState extends State<AbsenteesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton:  CircleAvatar(
        radius: 25,
        backgroundColor: constants().Themecolor,
        child: IconButton(
          onPressed: () {
             AdminViewModal().AdminVerification(
                () {
                  Navigator.pushNamed(context, RouteNames.Pdfscreen, arguments: {
              "List": widget.AbsentesList,
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
        centerTitle: true,
        backgroundColor: constants().Themecolor,
        title: const Center(child: Text("Absent People")),
      ),
      body: Container(
        decoration: BoxDecoration(color: constants().backgroundThemeColor),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(left: 7, right: 7),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: widget.AbsentesList.length,
                itemBuilder: (context, index) {
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
                          child: AttendanceTile(
                              context,
                              widget.AbsentesList[index].Name.toString(),
                              Colors.red)));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:newupdate/app/data/modals/meetingsmodal.dart';
import 'package:newupdate/utils/constants.dart';
import 'package:newupdate/utils/displaymessage.dart';
import 'package:newupdate/viewmodels/BackendManagement.dart';

class MeetingsScheduler extends StatefulWidget {
  const MeetingsScheduler({super.key});

  @override
  State<MeetingsScheduler> createState() => _MeetingsSchedulerState();
}

class _MeetingsSchedulerState extends State<MeetingsScheduler> {
  final BackendManagement _backendManagement = BackendManagement();
  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController description = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    @override
    dispose() {
    super.dispose();
      title.dispose();
      description.dispose();
    }

    return Container(
      color: constants().backgroundThemeColor,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 14, right: 14),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 300, bottom: 6),
                  child: Text(
                    "Title * ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: Colors.black),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Mention Title";
                      }
                      return null;
                    },
                    controller: title,
                    autofocus: true,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 215, bottom: 6, top: 20),
                  child: Text(
                    "Description * ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: Colors.black),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Mention Description";
                      }
                      return null;
                    },
                    controller: description,
                    autofocus: true,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        spreadRadius: 0.9,
                        blurStyle: BlurStyle.inner,
                        blurRadius: 7.0,
                        offset: Offset(0, 0.97))
                  ]),
                  child: ElevatedButton(
                    onPressed: () {
                      formKey.currentState!.validate();
                      try {
                        _backendManagement.CreateMeeting(MeetingsData(
                            Title: title.text, Description: description.text));
                        Utils.toastMessage("Meeting Scheduled Succesfully");
                      } catch (e) {
                        rethrow;
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black26;
                            } else {
                              return constants().Themecolor;
                            }
                          },
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.zero)))),
                    child: const Text(
                      "Schedule Meeting",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

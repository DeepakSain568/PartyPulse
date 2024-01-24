import 'package:cloud_firestore/cloud_firestore.dart';

class MeetingsData {
  String? Title;
  String? Description;
   List<MeetingsData> MeetingsList = [];

  MeetingsData({this.Title, this.Description});

  List<MeetingsData> GetMeetingsList() => MeetingsList;

  factory MeetingsData.FromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    if (data != null) {
      return MeetingsData(
          Title: data['Title'], Description: data['Description']);
    } else {
      return MeetingsData(Title: "Loading....", Description: "Loading...");
    }
  }

  Map<String, dynamic> ToFirestore() {
    return {
      if (Title != null) "Title": Title,
      if (Description != null) "Description": Description
    };
  }
}

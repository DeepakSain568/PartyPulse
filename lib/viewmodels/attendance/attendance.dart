import 'package:flutter/material.dart';
import 'package:newupdate/app/data/modals/userdata.dart';
import 'package:newupdate/viewmodels/BackendManagement.dart';

class Attendance with ChangeNotifier {
  Map<String, Map<int, bool>> AttendanceList = {
    "Absent": {},
    "Present": {},
    "Half Present": {}
  };

  final BackendManagement _backendManagement = BackendManagement();

  String GetAttendanceStatus(UserData userData) {
    return userData.Status.toString();
  }

  SetAttendanceStatus(UserData userData, String status) async{
    userData.Status = status;
    await _backendManagement.MarkAttendance(userData.UserID, status);
    print(userData.Name);
    print(userData.Status);
    notifyListeners();
  }

  String? _SearchThisIndexFromOtherAttendanceTypes(int index) {
    for (var key in AttendanceList.keys) {
      if (AttendanceList[key]!.containsKey(index)) {
        return key;
      }
    }
    return null;
  }

  void _RemoveThisIndexFromOtherAttendanceTypes(String key1, int key2) {
    AttendanceList[key1]!.remove(key2);
  }

  getAttendanceMark(int index) {
    String? AttendentypeKey1 = _SearchThisIndexFromOtherAttendanceTypes(index);
    return AttendentypeKey1;
  }

  set setAttendanceMark(Map details) {
    String? AttendentypeKey1 =
        _SearchThisIndexFromOtherAttendanceTypes(details["index"]);
    AttendentypeKey1 != null
        ? _RemoveThisIndexFromOtherAttendanceTypes(
            AttendentypeKey1, details["index"])
        : null;
    AttendanceList[details["mark"]]![details["index"]] = true;

    notifyListeners();
  }

  List<int> AttendanceTypeList(String Type) {
    return AttendanceList[Type]!.keys.toList();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class AdminsDataModal {
  String? Name;
  String? Email;
  String? PhoneNumber;
  String? UserID;
  String? Id;

  AdminsDataModal(
      {this.Name, this.Email, this.PhoneNumber, this.UserID, this.Id});

  factory AdminsDataModal.FromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return AdminsDataModal(
        Name: data?['Name'],
        Email: data?['Email'],
        PhoneNumber: data?['PhoneNumber'],
        UserID: data?['UserID'],
        Id: data?["Id"]);
  }

  Map<String, dynamic> ToFirestore() {
    return {
      if (Name != null) "Name": Name,
      if (Email != null) "Email": Email,
      if (PhoneNumber != null) "PhoneNumber": PhoneNumber,
      if (UserID != null) "UserID": UserID,
      if (Id != null) "Id": Id
    };
  }
}

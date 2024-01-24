import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:newupdate/app/data/modals/adminsmodal.dart';
import 'package:newupdate/app/data/modals/userdata.dart';
import 'package:newupdate/app/firebaseservices/firebaseservices.dart';
import 'package:newupdate/utils/displaymessage.dart';

class AdminViewModal with ChangeNotifier {
  Services services = Services();
  bool IsMainAdmin = false;
  bool IsSubAdmin = false;
  bool GeneralAdmin = false;
  AdminsDataModal? _adminsdata;

  get GetAdminsData => _adminsdata;

  final StreamController<bool> _generalAdminController =
      StreamController<bool>.broadcast();

  Stream<bool> get generalAdminStream => _generalAdminController.stream;

  setGeneralAdmin(bool value) {
    GeneralAdmin = value;
    _generalAdminController.add(value);
  }

  AdminVerification(
      Function verifyadmin, UserID, String displaymesssage) async {
    try {
      if (await IsAdmin(UserID)) {
        await verifyadmin();
      } else {
        Utils.toastMessage(displaymesssage.toString());
      }
    } catch (e) {
      Utils.toastMessage("Error During Admin Verification Try Again...");
    }
  }

  IsAdmin(UserID) async {
    try {
      final collectionReference = Services()
          .database
          .collection("Admins")
          .where('UserID', isEqualTo: UserID)
          .withConverter(
              fromFirestore: (snapshot, options) =>
                  AdminsDataModal.FromFirestore(snapshot),
              toFirestore: (AdminsDataModal userData, options) =>
                  AdminsDataModal().ToFirestore());

      QuerySnapshot<AdminsDataModal> querySnapshot =
          await collectionReference.get();

      if (querySnapshot.docs.isNotEmpty) {
        List<QueryDocumentSnapshot<AdminsDataModal>> adminsData =
            querySnapshot.docs.map((data) => data).toList();
        _adminsdata = adminsData[0].data();
        if (_adminsdata != null && _adminsdata!.Id == "Main Admin") {
          IsMainAdmin = true;
        }
        IsSubAdmin = true;
        if (IsMainAdmin || IsSubAdmin) {
          setGeneralAdmin(true);
        }
        print("IsSubAdmin $IsSubAdmin");
        return true;
      }
    } catch (e) {
      rethrow;
    }
    return false;
  }

  UpdateAdminsPosition(String Position, UserData userData) async {
    try {
      DocumentReference<AdminsDataModal> ref = services.database
          .collection("Admins")
          .doc(Position)
          .withConverter<AdminsDataModal>(
              fromFirestore: (snapshot, options) =>
                  AdminsDataModal.FromFirestore(snapshot),
              toFirestore: (AdminsDataModal userData, options) =>
                  userData.ToFirestore());
      await ref.update({
        "Email": userData.Email,
        "Name": userData.Name,
        "UserID": userData.UserID,
        "PhoneNumber": userData.phoneNumber,
      });
      Utils.GreentoastMessage("Admin Position Updated SuccessFully");
    } catch (e) {
      Utils.toastMessage("Network Error..  Try Again");
    }
  }
}

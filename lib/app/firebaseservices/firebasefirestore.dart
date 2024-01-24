import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newupdate/app/data/modals/meetingsmodal.dart';
import 'package:newupdate/app/data/modals/userdata.dart';
import 'package:newupdate/app/data/places.dart';
import 'package:newupdate/app/firebaseservices/firebaseservices.dart';
import 'package:newupdate/utils/constants.dart';
import '../data/modals/placesmodal.dart';

class FireStoreDataBase {
  Services services = Services();
  final TimeOut = const Duration(minutes: 1);

  updateData() async {
    print("inside update function");
    // await services.database.collection("deep");
    print("Loop Starts");
    for (String key in States().data.keys) {
      print(key);
      for (String element in States().data[key]!) {
        print(element);
        for (String Tehsil in States().Tehsil) {
           print(Tehsil);
          for (String Ward in States().Ward) {
             print(Ward);
            await services.database
                .collection("States")
                .doc(key)
                .collection("Districts")
                .doc(element)
                .collection("Tehsils")
                .doc(Tehsil)
                .collection("Address")
                .doc(Ward)
                .set({'exampleField': 'exampleValue'});
          }
        }
      }
    }
    print("Loop Ends");
  }

  DocumentReference<UserData> _UserReference(UserID) {
    DocumentReference<UserData> ref = services.database
        .collection("User")
        .doc(UserID)
        .withConverter<UserData>(
            fromFirestore: (snapshot, options) =>
                UserData.FromFirestore(snapshot),
            toFirestore: (UserData userData, options) =>
                userData.ToFirestore());
    return ref;
  }

  DocumentReference _MeetingsReference() {
    final ref = services.database
        .collection("Meetings")
        .doc()
        .withConverter<MeetingsData>(
            fromFirestore: (snapshot, options) =>
                MeetingsData.FromFirestore(snapshot),
            toFirestore: (MeetingsData meetingsData, options) =>
                meetingsData.ToFirestore());

    return ref;
  }

  Future<void> AddUserData(UserID, UserData userData) async {
    try {
      await _UserReference(UserID).set(userData).timeout(TimeOut);
    } catch (e) {
      print("Error adding data to Firestore: $e");
      rethrow;
    }
  }

  VerifyNumber(String PhoneNumber) async {
    UserData userData = UserData();
    try {
      final collectionReference = services.database
          .collection("User")
          .where('PhoneNumber', isEqualTo: PhoneNumber)
          .withConverter<UserData>(
              fromFirestore: (snapshot, options) =>
                  UserData.FromFirestore(snapshot),
              toFirestore: (UserData userData, options) =>
                  userData.ToFirestore());
      QuerySnapshot<UserData> querySnapshot = await collectionReference.get();
      if (querySnapshot.docs.isNotEmpty) {
        return true;
      }
    } catch (e) {
      rethrow;
    }
    return false;
  }

  VerifyData(Field, Value) async {
    try {
      final collectionReference = services.database
          .collection("User")
          .where('$Field', isEqualTo: Value)
          .withConverter<UserData>(
              fromFirestore: (snapshot, options) =>
                  UserData.FromFirestore(snapshot),
              toFirestore: (UserData userData, options) =>
                  userData.ToFirestore());
      QuerySnapshot<UserData> querySnapshot = await collectionReference.get();
      if (querySnapshot.docs.isNotEmpty) {
        return true;
      }
    } catch (e) {
      rethrow;
    }
    return false;
  }

  StoreProfileImage(UserId, File path) async {
    try {
      String name = DateTime.now().microsecondsSinceEpoch.toString();
      print(name);
      final referenceRoot = Services.Storage.ref();
      final referenceDirImages = referenceRoot.child('profileImages');
      final referenceImageToUpload = referenceDirImages.child(name);
      referenceImageToUpload.putFile(path);
   
    } catch (e) {
      rethrow;
    }
  }

  Future<UserData> UsersList() async {
    UserData userData = UserData();
    try {
      final collectionReference = services.database
          .collection("User")
          .withConverter<UserData>(
              fromFirestore: (snapshot, options) =>
                  UserData.FromFirestore(snapshot),
              toFirestore: (UserData userData, options) =>
                  userData.ToFirestore());
      QuerySnapshot<UserData> querySnapshot = await collectionReference.get();
      if (querySnapshot.docs.isNotEmpty) {
        userData.IndiaLevelUsers =
            querySnapshot.docs.map((doc) => doc.data()).toList();
        return userData;
      }
    } catch (e) {
      rethrow;
    }
    return userData;
  }

  Stream<DocumentSnapshot<UserData>> GetUserData(UserId) {
    final docsnap = _UserReference(UserId);
    return docsnap.snapshots();
  }

  UpdateUserData(UserId, String Field, String Value) async {
    try {
      await _UserReference(UserId).update({Field: Value});
    } catch (e) {
      rethrow;
    }
  }

  SetStatus(UserId, String status) async {
    try {
      await _UserReference(UserId).update({"Status": status});
    } catch (e) {
      rethrow;
    }
  }

  SetMeeting(MeetingsData meetingsData) async {
    try {
      await _MeetingsReference().set(meetingsData).timeout(TimeOut);
    } catch (e) {
      print("Error adding data to Firestore: $e");
      rethrow;
    }
  }

  Future<MeetingsData> GetAllMeetingsData() async {
    MeetingsData meetingsData = MeetingsData();

    try {
      final collectionReference = services.database
          .collection("Meetings")
          .withConverter<MeetingsData>(
              fromFirestore: (snapshot, SnapshotOptions) =>
                  MeetingsData.FromFirestore(snapshot),
              toFirestore: (MeetingsData meetingsData, options) =>
                  meetingsData.ToFirestore());

      QuerySnapshot<MeetingsData> querySnapshot = await collectionReference
          .get(const GetOptions(source: Source.serverAndCache));
      if (querySnapshot.docs.isNotEmpty) {
        print("Inside");
        meetingsData.MeetingsList =
            querySnapshot.docs.map((doc) => doc.data()).toList();
        return meetingsData;
      }
    } catch (e) {
      rethrow;
    }
    return meetingsData;
  }

  Future<UserData> UsersOfState(String state) async {
    UserData userData = UserData();
    try {
      final collectionReference = services.database
          .collection("User")
          .where('States', isEqualTo: state)
          .withConverter<UserData>(
              fromFirestore: (snapshot, options) =>
                  UserData.FromFirestore(snapshot),
              toFirestore: (UserData userData, options) =>
                  userData.ToFirestore());
      QuerySnapshot<UserData> querySnapshot = await collectionReference.get();
      if (querySnapshot.docs.isNotEmpty) {
        userData.UsersInState =
            querySnapshot.docs.map((doc) => doc.data()).toList();
        return userData;
      }
    } catch (e) {
      rethrow;
    }
    return userData;
  }

  Future<UserData> UsersOfDistrict(String state, String district) async {
    UserData userData = UserData();
    try {
      final collectionReference = services.database
          .collection("User")
          .where('States', isEqualTo: state)
          .where('Districts', isEqualTo: district)
          .withConverter<UserData>(
              fromFirestore: (snapshot, options) =>
                  UserData.FromFirestore(snapshot),
              toFirestore: (UserData userData, options) =>
                  userData.ToFirestore());
      QuerySnapshot<UserData> querySnapshot = await collectionReference.get();
      if (querySnapshot.docs.isNotEmpty) {
        userData.UsersInDistrict =
            querySnapshot.docs.map((doc) => doc.data()).toList();
        return userData;
      }
    } catch (e) {
      rethrow;
    }
    return userData;
  }

  Future<UserData> UsersOfTehsil(
      String state, String district, String Tehsil) async {
    UserData userData = UserData();
    try {
      final collectionReference = services.database
          .collection("User")
          .where('States', isEqualTo: state)
          .where('Districts', isEqualTo: district)
          .where('Tehsils', isEqualTo: Tehsil)
          .withConverter<UserData>(
              fromFirestore: (snapshot, options) =>
                  UserData.FromFirestore(snapshot),
              toFirestore: (UserData userData, options) =>
                  userData.ToFirestore());
      QuerySnapshot<UserData> querySnapshot = await collectionReference.get();
      if (querySnapshot.docs.isNotEmpty) {
        userData.UsersInTehsil =
            querySnapshot.docs.map((doc) => doc.data()).toList();
        return userData;
      }
    } catch (e) {
      rethrow;
    }
    return userData;
  }

  Future<UserData> UsersOfAddress(
      String state, String district, String Tehsil, String address) async {
    UserData userData = UserData();
    print("Inside Firestore users of address");

    try {
      final collectionReference = services.database
          .collection("User")
          .where('States', isEqualTo: state)
          .where('Districts', isEqualTo: district)
          .where('Tehsils', isEqualTo: Tehsil)
          .where('Address', isEqualTo: address)
          .withConverter<UserData>(
              fromFirestore: (snapshot, options) =>
                  UserData.FromFirestore(snapshot),
              toFirestore: (UserData userData, options) =>
                  userData.ToFirestore());
      QuerySnapshot<UserData> querySnapshot = await collectionReference.get();
      if (querySnapshot.docs.isNotEmpty) {
        userData.UsersonAddress =
            querySnapshot.docs.map((doc) => doc.data()).toList();
        print("Inside Firestore users of address");
        print(userData.UsersonAddress);
        return userData;
      }
      print("Inside Firestore users of address");
    } catch (e) {
      rethrow;
    }
    return userData;
  }

  Future<UserData> UsersOfAttendanceType(String Type) async {
    UserData userData = UserData();
    try {
      final collectionReference = services.database
          .collection("User")
          .where('Status', isEqualTo: Type)
          .withConverter<UserData>(
              fromFirestore: (snapshot, options) =>
                  UserData.FromFirestore(snapshot),
              toFirestore: (UserData userData, options) =>
                  userData.ToFirestore());
      QuerySnapshot<UserData> querySnapshot = await collectionReference.get();
      if (querySnapshot.docs.isNotEmpty) {
        if (Type == status.Absent.toString()) {
          userData.IndiaAbsentUsers =
              querySnapshot.docs.map((doc) => doc.data()).toList();
        } else if (Type == status.Waiting.toString()) {
          userData.IndiaHalfPresentUsers =
              querySnapshot.docs.map((doc) => doc.data()).toList();
        } else {
          userData.IndiaPresentUsers =
              querySnapshot.docs.map((doc) => doc.data()).toList();
        }
        print(userData.IndiaAbsentUsers);
        return userData;
      }
    } catch (e) {
      rethrow;
    }
    return userData;
  }

  Future<UserData> AddressUsersOfAttendanceType(String state, String district,
      String Tehsil, String address, String Type) async {
    UserData userData = UserData();
    try {
      final collectionReference = services.database
          .collection("User")
          .where('States', isEqualTo: state)
          .where('Districts', isEqualTo: district)
          .where('Tehsils', isEqualTo: Tehsil)
          .where('Address', isEqualTo: address)
          .where('Status', isEqualTo: Type)
          .withConverter<UserData>(
              fromFirestore: (snapshot, options) =>
                  UserData.FromFirestore(snapshot),
              toFirestore: (UserData userData, options) =>
                  userData.ToFirestore());
      QuerySnapshot<UserData> querySnapshot = await collectionReference.get();
      if (querySnapshot.docs.isNotEmpty) {
        if (Type == status.Absent.toString()) {
          userData.AbsentUsers =
              querySnapshot.docs.map((doc) => doc.data()).toList();
        } else if (Type == status.Waiting.toString()) {
          userData.HalfPresentUsers =
              querySnapshot.docs.map((doc) => doc.data()).toList();
        } else {
          userData.PresentUsers =
              querySnapshot.docs.map((doc) => doc.data()).toList();
        }
        return userData;
      }
    } catch (e) {
      rethrow;
    }
    return userData;
  }

  Future<UserData> StateUsersOfAttendanceType(String state, String Type) async {
    UserData userData = UserData();
    try {
      final collectionReference = services.database
          .collection("User")
          .where('States', isEqualTo: state)
          .where('Status', isEqualTo: Type)
          .withConverter<UserData>(
              fromFirestore: (snapshot, options) =>
                  UserData.FromFirestore(snapshot),
              toFirestore: (UserData userData, options) =>
                  userData.ToFirestore());
      QuerySnapshot<UserData> querySnapshot = await collectionReference.get();
      if (querySnapshot.docs.isNotEmpty) {
        if (Type == status.Absent.toString()) {
          userData.StateAbsentUsers =
              querySnapshot.docs.map((doc) => doc.data()).toList();
        } else if (Type == status.Waiting.toString()) {
          userData.StateHalfPresentUsers =
              querySnapshot.docs.map((doc) => doc.data()).toList();
        } else {
          userData.StatePresentUsers =
              querySnapshot.docs.map((doc) => doc.data()).toList();
        }
        return userData;
      }
    } catch (e) {
      rethrow;
    }
    return userData;
  }

  Future<UserData> TehsilUsersOfAttendanceType(
      String state, String district, String tehsil, String Type) async {
    UserData userData = UserData();
    try {
      final collectionReference = services.database
          .collection("User")
          .where('States', isEqualTo: state)
          .where('Districts', isEqualTo: district)
          .where('Tehsils', isEqualTo: tehsil)
          .where('Status', isEqualTo: Type)
          .withConverter<UserData>(
              fromFirestore: (snapshot, options) =>
                  UserData.FromFirestore(snapshot),
              toFirestore: (UserData userData, options) =>
                  userData.ToFirestore());
      QuerySnapshot<UserData> querySnapshot = await collectionReference.get();
      if (querySnapshot.docs.isNotEmpty) {
        if (Type == status.Absent.toString()) {
          userData.TehsilAbsentUsers =
              querySnapshot.docs.map((doc) => doc.data()).toList();
        } else if (Type == status.Waiting.toString()) {
          userData.TehsilHalfPresentUsers =
              querySnapshot.docs.map((doc) => doc.data()).toList();
        } else {
          userData.TehsilPresentUsers =
              querySnapshot.docs.map((doc) => doc.data()).toList();
        }
        return userData;
      }
    } catch (e) {
      rethrow;
    }
    return userData;
  }

  Future<UserData> DistrictUsersOfAttendanceType(
      String state, String district, String Type) async {
    UserData userData = UserData();
    try {
      final collectionReference = services.database
          .collection("User")
          .where('States', isEqualTo: state)
          .where('Districts', isEqualTo: district)
          .where('Status', isEqualTo: Type)
          .withConverter<UserData>(
              fromFirestore: (snapshot, options) =>
                  UserData.FromFirestore(snapshot),
              toFirestore: (UserData userData, options) =>
                  userData.ToFirestore());
      QuerySnapshot<UserData> querySnapshot = await collectionReference.get();
      if (querySnapshot.docs.isNotEmpty) {
        if (Type == status.Absent.toString()) {
          userData.DistrictAbsentUsers =
              querySnapshot.docs.map((doc) => doc.data()).toList();
        } else if (Type == status.Waiting.toString()) {
          userData.DistrictHalfPresentUsers =
              querySnapshot.docs.map((doc) => doc.data()).toList();
        } else {
          userData.DistrictPresentUsers =
              querySnapshot.docs.map((doc) => doc.data()).toList();
        }
        return userData;
      }
    } catch (e) {
      rethrow;
    }
    return userData;
  }

  Future<List<String>> GetStatesList() async {
    Places places = Places();
    try {
      final statesCollectionReference = services.database.collection("States");
      QuerySnapshot querySnapshot = await statesCollectionReference.get();
      if (querySnapshot.docs.isNotEmpty) {
        places.StatesList = querySnapshot.docs.map((doc) => doc.id).toList();
      }
    } catch (e) {
      rethrow;
    }
    return places.StatesList;
  }

  Future<List<String>> GetDistrictsList(String state) async {
    Places places = Places();
    try {
      final districtsCollectionReference = services.database
          .collection("States")
          .doc(state)
          .collection("Districts");
      QuerySnapshot querySnapshot = await districtsCollectionReference.get();
      places.CorrespondingDistrictsList =
          querySnapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      rethrow;
    }
    return places.CorrespondingDistrictsList;
  }

  Future<List<String>> GetTehsilsList(String state, String district) async {
    Places places = Places();
    try {
      final tehsilsCollectionReference = services.database
          .collection("States")
          .doc(state)
          .collection("Districts")
          .doc(district)
          .collection("Tehsils");
      QuerySnapshot querySnapshot = await tehsilsCollectionReference.get();
      places.TehsilsList = querySnapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      rethrow;
    }
    return places.TehsilsList;
  }

  Future<List<String>> GetAddressesList(
      String state, String district, String tehsil) async {
    Places places = Places();
    try {
      final addressesCollectionReference = services.database
          .collection("States")
          .doc(state)
          .collection("Districts")
          .doc(district)
          .collection("Tehsils")
          .doc(tehsil)
          .collection("Address");
      QuerySnapshot querySnapshot = await addressesCollectionReference.get();
      places.AddressesList = querySnapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      rethrow;
    }
    return places.AddressesList;
  }
}

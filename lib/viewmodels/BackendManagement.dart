import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:newupdate/app/data/modals/meetingsmodal.dart';
import 'package:newupdate/app/data/modals/placesmodal.dart';
import 'package:newupdate/app/data/modals/userdata.dart';
import 'package:newupdate/app/firebaseservices/firebasefirestore.dart';
import 'package:newupdate/app/firebaseservices/firebaseservices.dart';
import 'package:newupdate/utils/constants.dart';
import 'package:newupdate/utils/displaymessage.dart';
import 'package:newupdate/utils/routing/routenames.dart';
import 'package:newupdate/viewmodels/users/Authentication.dart';

class BackendManagement {
  final Authentication _authentication = Authentication();
  final FireStoreDataBase _dataBase = FireStoreDataBase();
  GlobalKey globalKey = GlobalKey();
  MeetingsData meetingsData = MeetingsData();
  UserData usersData = UserData();
  Places places = Places();

  SignUP(BuildContext context, UserData userDataObject) async {
    String Email = userDataObject.email;
    String Password = userDataObject.password;
    String PhoneNumber = userDataObject.phoneNumber;
    try {
      await _authentication.UserRegistration(Email, Password);
      final CurrentUser = Services.Authobject.currentUser;
      print(CurrentUser);
      if (CurrentUser != null) {
        userDataObject.UserID = CurrentUser.uid;
        await _dataBase.AddUserData(CurrentUser.uid, userDataObject);
        Navigator.pushNamed(context, RouteNames.homescreen,
            arguments: Services.Authobject.currentUser!.uid);
      }
    } catch (e) {
      print(e.toString());
      Utils.toastMessage(e.toString());
    }
  }

  CreateUsers(BuildContext context, UserData userDataObject) async {
    String Email = userDataObject.email;
    String Password = userDataObject.password;
    if (await VerifyIfThisDataPresent("Email", Email)) {
      Utils.toastMessage("This Email is already registered");
      return;
    } else {
      try {
        Uint8List bytes = Uint8List.fromList(utf8.encode(Email + Password));
        Digest digest = sha256.convert(bytes);
        String hashedString = digest.toString();
        userDataObject.UserID = hashedString;
        print("hashedString--->  $hashedString");
        await _dataBase.AddUserData(hashedString, userDataObject);
        Future.delayed(const Duration(milliseconds: 100));
        Utils.GreentoastMessage("User Created Succesfully");
      } catch (e) {
        print(e.toString());
        Utils.toastMessage(e.toString());
      }
    }
  }

  VerifyIfThisDataPresent(Field, Value) async {
    try {
      return await _dataBase.VerifyData(Field, Value);
    } catch (e) {
      Utils.toastMessage("Error Verifying Data... ");
    }
    return false;
  }

  FetchUserData(UserId) {
    return _dataBase.GetUserData(UserId);
  }

  UploadProfileImage(UserId, File path) async {
    try {
      await _dataBase.StoreProfileImage(UserId, path);
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
  }

  UpdateUserValues(
      {required UserId, required String Field, required String Value}) async {
    try {
      await _dataBase.UpdateUserData(UserId, Field, Value);
    } catch (e) {
      print(" UserDataUpdation $e");
      Utils.toastMessage(e.toString());
    }
  }

  MarkAttendance(UserId, String status) async {
    try {
      await _dataBase.SetStatus(UserId, status);
    } catch (e) {
      print(" mark attendance $e");
      Utils.toastMessage(e.toString());
    }
  }

  CreateMeeting(MeetingsData meetingsData) async {
    try {
      await _dataBase.SetMeeting(meetingsData);
    } catch (e) {
      print("Error while meeting Creation");
      Utils.toastMessage(e.toString());
    }
  }

  Future<List<MeetingsData>> MeetingsList() async {
    try {
      meetingsData = await _dataBase.GetAllMeetingsData();
    } catch (e) {
      print("Meetings related error $e");
      Utils.toastMessage(e.toString());
    }
    print(meetingsData.GetMeetingsList());
    return meetingsData.GetMeetingsList();
  }

  Future<List<UserData>> StateLevelUsers(String state) async {
    try {
      UserData DataOfUsers = await _dataBase.UsersOfState(state);
      usersData.UsersInState = DataOfUsers.UsersInState;
    } catch (e) {
      print("UsersOfState function error$e");
      Utils.toastMessage(e.toString());
    }

    return usersData.UsersInState;
  }

  Future<List<UserData>> DistrictLevelUsers(
      String state, String district) async {
    try {
      UserData DataOfUsers = await _dataBase.UsersOfDistrict(state, district);
      usersData.UsersInDistrict = DataOfUsers.UsersInDistrict;
    } catch (e) {
      print("UsersOfDistrict function error$e");
      Utils.toastMessage(e.toString());
    }
    return usersData.UsersInDistrict;
  }

  Future<List<UserData>> TehsilLevelUsers(
      String state, String district, String tehsil) async {
    try {
      UserData DataOfUsers =
          await _dataBase.UsersOfTehsil(state, district, tehsil);
      usersData.UsersInTehsil = DataOfUsers.UsersInTehsil;
    } catch (e) {
      print("UsersOfTehsil function error$e");
      Utils.toastMessage(e.toString());
    }

    return usersData.UsersInTehsil;
  }

  Future<List<UserData>> AddressLevelUsers(
      String state, String district, String tehsil, String address) async {
    try {
      UserData DataOfUsers =
          await _dataBase.UsersOfAddress(state, district, tehsil, address);
      usersData.UsersonAddress = DataOfUsers.UsersonAddress;
    } catch (e) {
      print("UsersOfAddress function error$e");
      Utils.toastMessage(e.toString());
    }
    print("Inside backend management");
    print(usersData.UsersonAddress);
    return usersData.UsersonAddress;
  }

  Future<List<UserData>> AbsentUsers(
      String state, String district, String tehsil, String address) async {
    try {
      UserData DataOfUsers = await _dataBase.AddressUsersOfAttendanceType(
          state, district, tehsil, address, status.Absent.toString());
      usersData.AbsentUsers = DataOfUsers.AbsentUsers;
    } catch (e) {
      print("UsersOfState function error$e");
      Utils.toastMessage(e.toString());
    }

    return usersData.AbsentUsers;
  }

  Future<List<UserData>> HalPresentUsers(
      String state, String district, String tehsil, String address) async {
    try {
      UserData DataOfUsers = await _dataBase.AddressUsersOfAttendanceType(
          state, district, tehsil, address, status.Waiting.toString());
      usersData.HalfPresentUsers = DataOfUsers.HalfPresentUsers;
    } catch (e) {
      print("UsersOfState function error$e");
      Utils.toastMessage(e.toString());
    }

    return usersData.HalfPresentUsers;
  }

  Future<List<UserData>> PresentUsers(
      String state, String district, String tehsil, String address) async {
    try {
      UserData DataOfUsers = await _dataBase.AddressUsersOfAttendanceType(
          state, district, tehsil, address, status.Present.toString());
      usersData.PresentUsers = DataOfUsers.PresentUsers;
    } catch (e) {
      print("UsersOfState function error$e");
      Utils.toastMessage(e.toString());
    }

    return usersData.PresentUsers;
  }

  Future<List<UserData>> indiaLevelUsers() async {
    try {
      UserData DataOfUsers = await _dataBase.UsersList();
      usersData.IndiaLevelUsers = DataOfUsers.IndiaLevelUsers;
    } catch (e) {
      print("UsersOfTehsil function error$e");
      Utils.toastMessage(e.toString());
    }

    return usersData.IndiaLevelUsers;
  }

  AttendanceTypeUsersLisTT(String Type) async {
    try {
      UserData DataOfUsers = await _dataBase.UsersOfAttendanceType(Type);
      if (Type == status.Absent.toString()) {
        usersData.IndiaAbsentUsers = DataOfUsers.IndiaAbsentUsers;
      } else if (Type == status.Waiting.toString()) {
        usersData.IndiaHalfPresentUsers = DataOfUsers.IndiaHalfPresentUsers;
      } else {
        usersData.IndiaPresentUsers = DataOfUsers.IndiaPresentUsers;
      }
    } catch (e) {
      print("UsersOfIndiaAttendanceType function error$e");
      Utils.toastMessage(e.toString());
    }
  }

  FetchStateLevelAttendanceTypeUsers(String state, String Type) async {
    try {
      UserData DataOfUsers =
          await _dataBase.StateUsersOfAttendanceType(state, Type);
      if (Type == status.Absent.toString()) {
        usersData.StateAbsentUsers = DataOfUsers.StateAbsentUsers;
      } else if (Type == status.Waiting.toString()) {
        usersData.StateHalfPresentUsers = DataOfUsers.StateHalfPresentUsers;
      } else {
        usersData.StatePresentUsers = DataOfUsers.StatePresentUsers;
      }
    } catch (e) {
      print("UsersOfStateAttendanceType function error$e");
      Utils.toastMessage(e.toString());
    }
  }

  FetchDistrictLevelAttendanceTypeUsers(
      String state, String district, String Type) async {
    try {
      UserData DataOfUsers =
          await _dataBase.DistrictUsersOfAttendanceType(state, district, Type);
      if (Type == status.Absent.toString()) {
        usersData.DistrictAbsentUsers = DataOfUsers.DistrictAbsentUsers;
      } else if (Type == status.Waiting.toString()) {
        usersData.DistrictHalfPresentUsers =
            DataOfUsers.DistrictHalfPresentUsers;
      } else {
        usersData.DistrictPresentUsers = DataOfUsers.DistrictPresentUsers;
      }
    } catch (e) {
      print("UsersOfdistrictAttendanceType function error$e");
      Utils.toastMessage(e.toString());
    }
  }

  FetchTehsilLevelAttendanceTypeUsers(
      String state, String district, String tehsil, String Type) async {
    try {
      UserData DataOfUsers = await _dataBase.TehsilUsersOfAttendanceType(
          state, district, tehsil, Type);
      if (Type == status.Absent.toString()) {
        usersData.TehsilAbsentUsers = DataOfUsers.TehsilAbsentUsers;
      } else if (Type == status.Waiting.toString()) {
        usersData.TehsilHalfPresentUsers = DataOfUsers.TehsilHalfPresentUsers;
      } else {
        usersData.TehsilPresentUsers = DataOfUsers.TehsilPresentUsers;
      }
    } catch (e) {
      print("UsersOftehsilAttendanceType function error$e");
      Utils.toastMessage(e.toString());
    }
  }

  Future<List<String>> FetchStatesList() async {

    print("FetchStatesList function");
    try {
      places.StatesList = await _dataBase.GetStatesList();
    } catch (e) {
      print("FetchStatesList Error $e");
      Utils.toastMessage(e.toString());
    }
    print("Inside FetchStates List");
    print(places.StatesList.length);
    return places.StatesList;
  }

  Future<List<String>> FetchDistrictsList(String state) async {
    try {
      places.CorrespondingDistrictsList =
          await _dataBase.GetDistrictsList(state);
    } catch (e) {
      print("FetchDistrictsList Error $e");
      Utils.toastMessage(e.toString());
    }
    return places.CorrespondingDistrictsList;
  }

  Future<List<String>> FetchTehsilsList(String state, String district) async {
    try {
      places.TehsilsList = await _dataBase.GetTehsilsList(state, district);
    } catch (e) {
      print("FetchTehsilsList Error $e");
      Utils.toastMessage(e.toString());
    }
    return places.TehsilsList;
  }

  Future<List<String>> FetchAddressList(
      String state, String district, String tehsil) async {
    try {
      places.AddressesList =
          await _dataBase.GetAddressesList(state, district, tehsil);
    } catch (e) {
      print("FetchTehsilsList Error $e");
      Utils.toastMessage(e.toString());
    }
    return places.AddressesList;
  }
}

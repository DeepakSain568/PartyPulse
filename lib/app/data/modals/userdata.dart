import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String? Name;
  String? Email;
  String? Password;
  String? PhoneNumber;
  String? State;
  String? District;
  String? Tehsil;
  String? Address;
  String? Status;
  String? UserID;
  String? ProfileImageUrl;
  get phoneNumber => PhoneNumber;
  get email => Email;
  get password => Password;

  List<UserData> UsersInState = [];
  List<UserData> UsersInDistrict = [];
  List<UserData> UsersInTehsil = [];
  List<UserData> UsersonAddress = [];
  List<UserData> AbsentUsers = [];
  List<UserData> PresentUsers = [];
  List<UserData> HalfPresentUsers = [];
  List<UserData> StateAbsentUsers = [];
  List<UserData> StatePresentUsers = [];
  List<UserData> StateHalfPresentUsers = [];
  List<UserData> DistrictAbsentUsers = [];
  List<UserData> DistrictPresentUsers = [];
  List<UserData> DistrictHalfPresentUsers = [];
  List<UserData> TehsilAbsentUsers = [];
  List<UserData> TehsilPresentUsers = [];
  List<UserData> TehsilHalfPresentUsers = [];
  List<UserData> IndiaAbsentUsers = [];
  List<UserData> IndiaPresentUsers = [];
  List<UserData> IndiaHalfPresentUsers = [];
  List<UserData> IndiaLevelUsers = [];

  // UserData(Name: Name, Email: Email, Password: Password, PhoneNumber: PhoneNumber, State: State, District: District, Tehsil: Tehsil, Address: Address)

  UserData(
      {this.Name,
      this.Email,
      this.Password,
      this.PhoneNumber,
      this.State,
      this.District,
      this.Tehsil,
      this.Address,
      this.Status,
      this.UserID,
      this.ProfileImageUrl});

  factory UserData.FromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return UserData(
      Name: data?['Name'],
      Email: data?['Email'],
      Password: data?['Password'],
      PhoneNumber: data?['PhoneNumber'],
      State: data?['State'],
      District: data?['District'],
      Tehsil: data?['Tehsil'],
      Address: data?['Address'],
      Status: data?['Status'],
      UserID: data?["UserID"],
      ProfileImageUrl: data?["ImageUrl"],
    );
  }

  Map<String, dynamic> ToFirestore() {
    return {
      if (Name != null) "Name": Name,
      if (Email != null) "Email": Email,
      if (PhoneNumber != null) "PhoneNumber": PhoneNumber,
      if (State != null) "State": State,
      if (District != null) "District": District,
      if (Tehsil != null) "Tehsil": Tehsil,
      if (Address != null) "Address": Address,
      if (Status != null) "Status": Status,
      if (UserID != null) "UserID": UserID,
      if (ProfileImageUrl != null) "ImageUrl": ProfileImageUrl
    };
  }
}

import 'package:flutter/material.dart';
import 'package:newupdate/app/data/modals/userdata.dart';
import 'package:newupdate/viewmodels/adminsviewmodal/AdminViewModal.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../utils/displaymessage.dart';
import '../utils/widgets/widgets.dart';
import '../viewmodels/BackendManagement.dart';
import '../viewmodels/users/duringlogin.dart';

class AssignAdminPositionPage extends StatefulWidget {
  const AssignAdminPositionPage({super.key});

  @override
  State<AssignAdminPositionPage> createState() =>
      _AssignAdminPositionPageState();
}

class _AssignAdminPositionPageState extends State<AssignAdminPositionPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final BackendManagement _backendManagement = BackendManagement();
  final AdminViewModal _adminViewModal = AdminViewModal();
  String? State;
  String? District;
  String? Tehsil;
  String? Address;
  UserData? _userData;
  String? Person;
  String? Position;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initializeStates();
    State = null;
    District = null;
    Tehsil = null;
    Address = null;
    _userData = null;
    Person = null;
  }

  void initializeStates() async {
    await _backendManagement.FetchStatesList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: constants().Themecolor,
        title: const Text("Change SubAdmin",
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: constants().backgroundThemeColor),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropDownList(
                          onSelecte: (Value) async {
                            State = Value;
                            if (State != null) {
                              await _backendManagement.FetchDistrictsList(
                                  State!);
                            }
                            Tehsil = null;
                            Address = null;
                            District = null;
                            setState(() {});
                          },
                          NewValue: State,
                          Locations:
                              _backendManagement.places.StatesList.isEmpty
                                  ? ["Goa"]
                                  : _backendManagement.places.StatesList,
                          Typename: "State",
                          iCon: Icons.place),
                      DropDownList(
                          onSelecte: (Value) async {
                            District = Value;
                            if (State != null && District != null) {
                              await _backendManagement.FetchTehsilsList(
                                  State!, District!);
                            }
                            Address = null;
                            Tehsil = null;
                            setState(() {});
                          },
                          NewValue: District,
                          Locations: _backendManagement
                                  .places.CorrespondingDistrictsList.isEmpty
                              ? ["North Goa"]
                              : _backendManagement
                                  .places.CorrespondingDistrictsList,
                          Typename: "District",
                          iCon: Icons.place),
                      DropDownList(
                          onSelecte: (Value) async {
                            Tehsil = Value;

                            if (State != null &&
                                District != null &&
                                Tehsil != null) {
                              await _backendManagement.FetchAddressList(
                                  State!, District!, Tehsil!);
                            }
                            Address = null;
                            setState(() {});
                          },
                          NewValue: Tehsil,
                          Locations:
                              _backendManagement.places.TehsilsList.isEmpty
                                  ? ["Tehsil1"]
                                  : _backendManagement.places.TehsilsList,
                          Typename: "Tehsil",
                          iCon: Icons.location_city),
                      DropDownList(
                          onSelecte: (Value) async {
                            Address = Value;
                            if (State != null &&
                                District != null &&
                                Tehsil != null &&
                                Address != null) {
                              await _backendManagement.AddressLevelUsers(
                                  State!, District!, Tehsil!, Address!);
                            }
                            _userData = null;
                            setState(() {});
                          },
                          NewValue: Address,
                          Locations:
                              _backendManagement.places.AddressesList.isEmpty
                                  ? ["Address1"]
                                  : _backendManagement.places.AddressesList,
                          Typename: "Address",
                          iCon: Icons.location_city_outlined),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: DropdownButtonFormField<String>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Select the Field";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                fillColor: constants().FieldsColor,
                                prefixIcon: const Icon(
                                  Icons.people,
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              hint: const Text("Peoples List"),
                              value: Person,
                              onChanged: (value) async {
                                Person = value;
                                _userData = _backendManagement
                                    .usersData.UsersonAddress
                                    .firstWhere(
                                        (userData) => userData.Name == value);
                              },
                              icon: const Icon(Icons.arrow_drop_down),
                              items: _backendManagement.usersData.UsersonAddress
                                  .map<DropdownMenuItem<String>>(
                                      (UserData value) {
                                return DropdownMenuItem<String>(
                                  value: value.Name,
                                  child: Text(value.Name!),
                                );
                              }).toList()),
                        ),
                      ),
                      DropDownList(
                          onSelecte: (Value) async {
                            Position = Value;
                            setState(() {});
                          },
                          NewValue: Position,
                          Locations: [
                            "SubAdmin 1",
                            "SubAdmin 2",
                            "SubAdmin 3",
                            "SubAdmin 4",
                            "SubAdmin 5"
                          ],
                          Typename: "SubAdmin Positions",
                          iCon: Icons.admin_panel_settings),
                      Consumer<Loading>(
                          builder: (context, value, child) =>
                              SignInSignUpButton(
                                  context,
                                  "Assign Admin Position",
                                  value.GetAssignAdminLoadung, () async {
                                value.SetAssignAdminLoadung = true;
                                if (Position != null && _userData != null) {
                                  _adminViewModal.UpdateAdminsPosition(
                                      Position!, _userData!);
                                  Utils.GreentoastMessage(
                                      "$Position Position Updated Successfully");
                                }
                                value.SetAssignAdminLoadung = false;
                              }, _formKey)),
                    ],
                  )
                  )),
        ),
      ),
    );
  }
}

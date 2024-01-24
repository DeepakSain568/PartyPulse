import 'package:flutter/material.dart';
import 'package:newupdate/utils/routing/routenames.dart';
import 'package:newupdate/views/adminassignview.dart';
import 'package:newupdate/views/authentication/createusers.dart';
import 'package:newupdate/views/authentication/login/login.dart';
import 'package:newupdate/views/authentication/login/phonenumberlogin.dart';
import 'package:newupdate/views/authentication/login/otpverification.dart';
import 'package:newupdate/views/authentication/register/register.dart';
import 'package:newupdate/views/districts/districts.dart';
import 'package:newupdate/views/homepage/homepage.dart';
import 'package:newupdate/views/meetings/meetings.dart';
import 'package:newupdate/views/address/address.dart';
import 'package:newupdate/views/pdf/pdf.dart';
import 'package:newupdate/views/peoples/absenteeslist.dart';
import 'package:newupdate/views/peoples/halfpresenteeslist.dart';
import 'package:newupdate/views/peoples/peopleslist.dart';
import 'package:newupdate/views/peoples/presenteeslist.dart';
import 'package:newupdate/views/splash_screen.dart';
import 'package:newupdate/views/tehsil/tehsil.dart';
import 'package:newupdate/views/userprofile/userprofile.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashscreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case RouteNames.loginscreen:
        return MaterialPageRoute(builder: (context) => const loginPage());

      case RouteNames.emailpasswordloginscreen:
        return MaterialPageRoute(
            builder: (context) => const EmailPasswordloginPage());

      case RouteNames.registerscreen:
        return MaterialPageRoute(builder: (context) => const RegisterPage());

      case RouteNames.homescreen:
        return MaterialPageRoute(
            builder: (context) =>
                HomePage(UserId: settings.arguments.toString()));

      case RouteNames.otpscreen:
        return MaterialPageRoute(
            builder: (context) => OTPVerificationScreen(
                  verificationId: settings.arguments.toString(),
                ));

      case RouteNames.districtsscreen:
        return MaterialPageRoute(
            builder: (context) =>
                Districts(state: settings.arguments.toString()));

      case RouteNames.tehsilssscreen:
        return MaterialPageRoute(
            builder: (context) => tehsilsPage(
                  tehsilData: settings.arguments as Map,
                ));

      case RouteNames.meetingsscreen:
        return MaterialPageRoute(builder: (context) => const Meetings());

      case RouteNames.abseentpeoplescreen:
        return MaterialPageRoute(
            builder: (context) => AbsenteesList(
                  AbsentesList: settings.arguments as List,
                ));

      case RouteNames.halfpresentpeoplescreen:
        return MaterialPageRoute(
            builder: (context) => HalfPresenteesScreen(
                HalfPresentesList: settings.arguments as List));

      case RouteNames.presentpeoplescreen:
        return MaterialPageRoute(
            builder: (context) =>
                PresenteesScreen(PresentesList: settings.arguments as List));

      case RouteNames.peoplescreen:
        return MaterialPageRoute(
            builder: (context) =>
                peoplesPage(peoples: settings.arguments as Map));

      case RouteNames.addresscreen:
        return MaterialPageRoute(
            builder: (context) =>
                Addresses(address: settings.arguments as Map));

      case RouteNames.Pdfscreen:
        return MaterialPageRoute(
            builder: (context) => PdfView(
                  Data: settings.arguments as Map,
                ));

      case RouteNames.userProfilescreen:
        return MaterialPageRoute(
          builder: (context) =>
              UserProfile(UserID: settings.arguments.toString()),
        );

      case RouteNames.AdminAssignscreen:
        return MaterialPageRoute(
          builder: (context) => const AssignAdminPositionPage(),
        );

      case RouteNames.CreateUserScreen:
        return MaterialPageRoute(builder: (context) => const CreateUserPage());

      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(
                child: Text("Something error"),
              ),
            );
          },
        );
    }
  }
}

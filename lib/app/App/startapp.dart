import 'package:flutter/material.dart';
import 'package:newupdate/utils/constants.dart';
import 'package:newupdate/utils/routing/routenames.dart';
import 'package:newupdate/utils/routing/routes.dart';
import 'package:newupdate/viewmodels/adminsviewmodal/AdminViewModal.dart';
import 'package:newupdate/viewmodels/userprofile/profileviewmodal.dart';
import 'package:newupdate/viewmodels/users/duringlogin.dart';
import 'package:newupdate/viewmodels/users/registration.dart';
import 'package:provider/provider.dart';

class StartApp extends StatefulWidget {
  const StartApp({super.key});

  @override
  State<StartApp> createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Loading(),
          ),
          ChangeNotifierProvider(create: (context) => Registration()),
          ChangeNotifierProvider(create:  (context) =>ProfileViewModal()),
          ChangeNotifierProvider(create:  (context) =>AdminViewModal() ,)
        ],
        child: SafeArea(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: constants().Themecolor,
            ),
            initialRoute: RouteNames.splashscreen,
            onGenerateRoute: Routes.generateRoute,
          ),
        ));
  }
}

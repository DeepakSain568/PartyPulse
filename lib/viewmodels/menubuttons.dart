import 'package:flutter/material.dart';
import 'package:newupdate/utils/routing/routenames.dart';

class MenuButtons {
  Meetings(BuildContext context) {
    Navigator.popAndPushNamed(context, RouteNames.meetingsscreen);
  }

  AdminAssign(BuildContext context){
      
  Navigator.popAndPushNamed(context, RouteNames.AdminAssignscreen);

  }

  UserProfile(BuildContext context,String UserId) {
  
      Navigator.popAndPushNamed(context, RouteNames.userProfilescreen,arguments: UserId);
    
  }
}

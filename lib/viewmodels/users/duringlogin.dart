import 'package:flutter/foundation.dart';

class Loading with ChangeNotifier {
  bool _loadingemailpasswordlogin = false;
  bool _loadingotplogin = false;
  bool _loadingsignup = false;
  bool _loadingAssignAdmin = false;
   

   get GetAssignAdminLoadung => _loadingAssignAdmin;
  set SetAssignAdminLoadung(bool val) {
    _loadingAssignAdmin = val;
    notifyListeners();
  }


  get GetEmailPasswordLoginLoading => _loadingemailpasswordlogin;
  set SetEmailPasswordLoginLoading(bool val) {
    _loadingemailpasswordlogin = val;
    notifyListeners();
  }

  get GetOtpLoginLoading => _loadingotplogin;
  set SetOtpLoginLoading(bool val) {
    _loadingotplogin = val;
    notifyListeners();
  }

  get GetSignupLoading => _loadingsignup;
  set SetSignupLoading(bool val) {
    _loadingsignup = val;
    notifyListeners();
  }
}

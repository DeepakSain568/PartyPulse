import 'package:flutter/material.dart';

class Registration with ChangeNotifier {
  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode PhoneFocusNode = FocusNode();
  TextEditingController name = TextEditingController();
  FieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    nextFocus.requestFocus();
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/data/modals/globalvariables.dart';

class ProfileViewModal with ChangeNotifier {
  bool _name = true;
  bool _email = true;
  bool _number = true;
  get Name => _name;
  get Email => _email;
  get Number => _number;

  set NameField(bool val) {
    _name = val;
    notifyListeners();
  }

  set EmailField(bool val) {
    _email = val;
    notifyListeners();
  }

  set NumberField(bool val) {
    _number = val;
    notifyListeners();
  }

  Future<File?> SelectImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      notifyListeners();
      IMAGE =  File(pickedFile.path);
      return File(pickedFile.path);
    } else {
      print("No Image Selected");
    }
    notifyListeners();
    return null;
  }
}

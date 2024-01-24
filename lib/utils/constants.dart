// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class constants {
  Color Themecolor = Colors.orange[600]!;
  Color backgroundThemeColor = Colors.amber[50]!;
  Color presenteesColor = Colors.green;
  Color AbsenteesColor = Colors.red;
  Color HalfPresenteesColor = Colors.yellow;
  Color FieldsColor = Colors.white;
  Color ProfileTilesColor = Colors.orange[100]!;
  
}

enum status<String> { NoValue, Waiting, Present, Absent }

import 'package:flutter/material.dart';

AttendanceTile(BuildContext context, String title, Color color) {
  return ListTile(
    leading: CircleAvatar(
      radius: 15,
      backgroundColor: color,
    ),
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ),
    shape: const BeveledRectangleBorder(
      side: BorderSide(width: 1, color: Colors.black),
    ),
  );
}

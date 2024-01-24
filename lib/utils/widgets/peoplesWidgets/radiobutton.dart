import 'package:flutter/material.dart';
import 'package:newupdate/utils/constants.dart';


PopupMenuButton RadioButton(
    BuildContext context, String? selected, AfterSelected) {
  return PopupMenuButton(
    onSelected: (value) async{
     await AfterSelected(value);
    },
    icon: selected == status.NoValue.toString()
        ? const Icon(Icons.radio_button_off)
        : CircleAvatar(
            radius: 20,
            backgroundColor: selected == status.Present.toString()
                ? Colors.green
                : selected == status.Waiting.toString()
                    ? Colors.yellow
                    : Colors.red,
          ),
    itemBuilder: (context) {
      return <PopupMenuEntry>[
        PopupMenuItem(
            value: status.Present.toString(),
            child: ListTile(
              leading: const CircleAvatar(
                radius: 10,
                backgroundColor: Colors.green,
              ),
              title: Text(status.Present.toString()),
            )),
        PopupMenuItem(
            value: status.Waiting.toString(),
            child: ListTile(
              leading: const CircleAvatar(
                radius: 10,
                backgroundColor: Colors.yellow,
              ),
              title: Text(status.Waiting.toString()),
            )),
        PopupMenuItem(
            value: status.Absent.toString(),
            child: ListTile(
              leading: const CircleAvatar(
                radius: 10,
                backgroundColor: Colors.red,
              ),
              title: Text(status.Absent.toString()),
            ))
      ];
    },
  );
}

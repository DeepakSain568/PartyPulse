import 'package:flutter/material.dart';
import 'package:newupdate/utils/constants.dart';

import '../displaymessage.dart';

Container UserInfoTile(
    BuildContext context, String title, Function onTap, IconData icon) {
  return Container(
      height: 55,
      width: MediaQuery.of(context).size.width * 0.94,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        color: constants().ProfileTilesColor,
      ),
      child: Center(
        child: ListTile(
          leading: Icon(icon),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          trailing: InkWell(
              onTap: () {
                onTap();
              },
              child: const Icon(Icons.edit)),
          shape: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
        ),
      ));
}

Container ProfileInputField(BuildContext context, GlobalKey<FormState> formKey,
    Function onTap, IconData icon, TextEditingController controller) {
  return Container(
    height: 55,
    width: MediaQuery.of(context).size.width * 0.94,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(40)),
      color: constants().ProfileTilesColor,
    ),
    child: Center(
      child: ListTile(
        leading: Icon(icon),
        title: TextFormField(
          cursorColor: Colors.black,
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please Enter in Field";
            }
            return null;
          },
          style: TextStyle(color: Colors.black.withOpacity(0.9)),
        ),
        trailing: InkWell(
            onTap: () async {
              if (formKey.currentState!.validate()) {
                await onTap();
              } else {
                Utils.toastMessage("Enter Valid Details");
              }
              await onTap();
            },
            child: const Icon(Icons.save)),
        shape: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black),
        ),
      ),
    ),
  );
}

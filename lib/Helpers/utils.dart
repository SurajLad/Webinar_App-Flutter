import 'dart:math';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

String getAgoraAppId() {
  return "ef0a2920a8414c648d0e92f553b9fd63"; // Return Your Agora App Id
}

checkNoSignleDigit(int no) {
  int len = no.toString().length;
  if (len == 1) {
    return true;
  }
  return false;
}

String generateRandomString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

Future<bool> handlePermissionsForCall(BuildContext context) async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.microphone,
    Permission.storage,
  ].request();

  if (statuses[Permission.storage].isPermanentlyDenied) {
    showCustomDialog(context, "Permission Required",
        "Storage Permission Required for Video Call", () {
      Navigator.pop(context);
      openAppSettings();
    });
    return false;
  } else if (statuses[Permission.camera].isPermanentlyDenied) {
    showCustomDialog(context, "Permission Required",
        "Camera Permission Required for Video Call", () {
      Navigator.pop(context);
      openAppSettings();
    });
    return false;
  } else if (statuses[Permission.microphone].isPermanentlyDenied) {
    showCustomDialog(context, "Permission Required",
        "Microphone Permission Required for Video Call", () {
      Navigator.pop(context);
      openAppSettings();
    });
    return false;
  }

  if (statuses[Permission.storage].isDenied) {
    return false;
  } else if (statuses[Permission.camera].isDenied) {
    return false;
  } else if (statuses[Permission.microphone].isDenied) {
    return false;
  }
  return true;
}

void showCustomDialog(BuildContext context, String title, String message,
    Function okPressed) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: new Text(
          title,
          style: TextStyle(fontFamily: 'WorkSansMedium'),
        ),
        content: new Text(
          message,
          style: TextStyle(fontFamily: 'WorkSansMedium'),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text("OK"),
            onPressed: okPressed,
          ),
        ],
      );
    },
  );
}

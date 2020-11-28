import 'package:agora_rtc_engine/rtc_engine.dart' as RTC;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xbsl_task/Helpers/constants.dart';
import 'package:xbsl_task/Helpers/text_styles.dart';
import 'package:xbsl_task/Helpers/utils.dart';
import 'package:xbsl_task/UI/webinar_screen.dart';
import 'package:xbsl_task/controller/appController.dart';

class CreateWebinarDialog extends StatefulWidget {
  @override
  _CreateWebinarDialogState createState() => _CreateWebinarDialogState();
}

class _CreateWebinarDialogState extends State<CreateWebinarDialog> {
  String roomId = "";
  TextEditingController nameTxtController = TextEditingController();
  TextEditingController creatorNameController = TextEditingController();
  AppController appController = Get.find<AppController>();
  FirebaseDatabase database;

  @override
  void initState() {
    database = FirebaseDatabase(app: appController.app);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 600),
      switchInCurve: Curves.easeInOut,
      child: roomId.isEmpty
          ? buildCreateWebinarDialog(context)
          : buildWebinarSuccess(context),
    );
  }

  AlertDialog buildWebinarSuccess(BuildContext context) {
    return AlertDialog(
      key: UniqueKey(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text("Webinar Created",
          style: midBoldTxtStyle.copyWith(color: appThemeColor)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/room_created_vector.png',
          ),
          const SizedBox(height: 20),
          Text(
            "Invite id : " + roomId,
            style: midTxtStyle.copyWith(color: const Color(0xFF1A1E78)),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                color: const Color(0xFF1A1E78),
                onPressed: () {
                  Get.snackbar("Coming Soon", "",
                      backgroundColor: Colors.white,
                      colorText: Color(0xFF1A1E78),
                      snackPosition: SnackPosition.BOTTOM);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.share, color: Colors.white),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Share",
                      style: regularTxtStyle,
                    ),
                  ],
                ),
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                color: const Color(0xFF1A1E78),
                onPressed: () async {
                  bool isPermissionGranted =
                      await handlePermissionsForCall(context);
                  if (isPermissionGranted) {
                    await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebinarScreen(
                          channelName: roomId,
                          role: RTC.ClientRole.Broadcaster,
                          webinarTitle: nameTxtController.text,
                          hostName: creatorNameController.text,
                        ),
                      ),
                    );
                  } else {
                    Get.snackbar("Failed",
                        "Microphone Permission Required for Video Call.",
                        backgroundColor: Colors.white,
                        colorText: Color(0xFF1A1E78),
                        snackPosition: SnackPosition.BOTTOM);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_forward, color: Colors.white),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Join",
                      style: regularTxtStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AlertDialog buildCreateWebinarDialog(BuildContext context) {
    return AlertDialog(
      key: UniqueKey(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text("Create Webinar"),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: creatorNameController,
                decoration: InputDecoration(
                    hintText: "Enter Creator Name",
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color(0xFF1A1E78), width: 2)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color(0xFF1A1E78), width: 2))),
                style: regularTxtStyle.copyWith(
                    color: const Color(0xFF1A1E78),
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameTxtController,
                decoration: InputDecoration(
                    hintText: "Enter Webinar Name",
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color(0xFF1A1E78), width: 2)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color(0xFF1A1E78), width: 2))),
                style: regularTxtStyle.copyWith(
                    color: const Color(0xFF1A1E78),
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                color: const Color(0xFF1A1E78),
                onPressed: () async {
                  if (creatorNameController.text.isNotEmpty &&
                      nameTxtController.text.isNotEmpty) {
                    roomId = generateRandomString(8);
                    var update = {
                      NAME: nameTxtController.text,
                      CREATOR: creatorNameController.text,
                      DATETIME: DateFormat("dd-mm-yyyy").format(DateTime.now()),
                      CODE: roomId,
                    };
                    await database
                        .reference()
                        .child(WEBINAR)
                        .child(nameTxtController.text)
                        .update(update)
                        .then((value) {
                      setState(() {
                        // Update UI
                      });
                    });
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_forward, color: Colors.white),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Create Webinar",
                      style: regularTxtStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

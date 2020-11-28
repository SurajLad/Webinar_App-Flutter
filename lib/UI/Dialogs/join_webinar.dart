import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbsl_task/Helpers/constants.dart';
import 'package:xbsl_task/Helpers/text_styles.dart';
import 'package:xbsl_task/Helpers/utils.dart';
import 'package:xbsl_task/UI/webinar_screen.dart';
import 'package:agora_rtc_engine/rtc_engine.dart' as RTC;
import 'package:xbsl_task/controller/appController.dart';

class JoinWebinarScreen extends StatefulWidget {
  @override
  _JoinWebinarScreenState createState() => _JoinWebinarScreenState();
}

class _JoinWebinarScreenState extends State<JoinWebinarScreen> {
  final TextEditingController roomTxtController = TextEditingController();
  final AppController appController = Get.find<AppController>();

  @override
  void initState() {
    appController.getOngoingWebinar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appThemeColor,
        title: Text(
          "Join Webinar",
          style: midTxtStyle,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 18.0, right: 18),
        child: ListView(
          shrinkWrap: true,
          children: [
            Image.asset(
              'assets/room_join_vector.png',
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: roomTxtController,
              decoration: InputDecoration(
                  hintText: "Enter Invite id to join",
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: const Color(0xFF1A1E78), width: 2)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color(0xFF1A1E78), width: 2))),
              style: regularTxtStyle.copyWith(
                  color: const Color(0xFF1A1E78), fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              color: const Color(0xFF1A1E78),
              onPressed: () async {
                if (roomTxtController.text.isNotEmpty) {
                  bool isPermissionGranted =
                      await handlePermissionsForCall(context);
                  if (isPermissionGranted) {
                    await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebinarScreen(
                          channelName: roomTxtController.text,
                          role: RTC.ClientRole.Audience,
                        ),
                      ),
                    );
                  } else {
                    Get.snackbar("Failed", "Enter Room-Id to Join.",
                        backgroundColor: Colors.white,
                        colorText: Color(0xFF1A1E78),
                        snackPosition: SnackPosition.BOTTOM);
                  }
                } else {
                  Get.snackbar(
                      "Failed", "invite code is required to join webinar.",
                      backgroundColor: Colors.white,
                      colorText: Color(0xFF1A1E78),
                      snackPosition: SnackPosition.BOTTOM);
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_forward, color: Colors.white),
                  const SizedBox(width: 20),
                  Text("Join Webinar", style: regularTxtStyle),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black54,
                    height: 2,
                  ),
                ),
                const SizedBox(width: 10),
                Text("On Going Events"),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    color: Colors.black54,
                    height: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GetBuilder<AppController>(builder: (_) {
              return Container(
                height: 200,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: appThemeColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        onTap: () async {
                          bool isPermissionGranted =
                              await handlePermissionsForCall(context);
                          if (isPermissionGranted) {
                            await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WebinarScreen(
                                  channelName:
                                      _.onGoiningWebinarList[index].code,
                                  role: RTC.ClientRole.Audience,
                                  webinarTitle:
                                      _.onGoiningWebinarList[index].name,
                                  hostName:
                                      _.onGoiningWebinarList[index].creatorName,
                                ),
                              ),
                            );
                          } else {
                            Get.snackbar("Failed", "Enter Room-Id to Join.",
                                backgroundColor: Colors.white,
                                colorText: Color(0xFF1A1E78),
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        },
                        title: Text(
                          _.onGoiningWebinarList[index].name,
                          style: regularBoldTxtStyle.copyWith(
                              color: appThemeColor),
                        ),
                        subtitle: Text(
                          _.onGoiningWebinarList[index].creatorName,
                          style: regularTxtStyle.copyWith(color: appThemeColor),
                        ),
                        trailing: Text(
                          _.onGoiningWebinarList[index].dateTime,
                          style: regularTxtStyle.copyWith(color: appThemeColor),
                        ),
                      ),
                    );
                  },
                  itemCount: _.onGoiningWebinarList.length,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:get/get.dart';
import 'package:xbsl_task/Helpers/utils.dart';

class AgoraController extends GetxController {
  Timer webinarTimer;
  int webinarDurationInSec = 0;
  var webinarDurationInString = "00:00".obs;

  void startWatchTime() async {
    webinarTimer = Timer.periodic(
      const Duration(seconds: 1),
      (meetingTimer) {
        int min = (webinarDurationInSec ~/ 60);
        int sec = (webinarDurationInSec % 60).toInt();

        webinarDurationInString.value =
            min.toString() + ":" + sec.toString() + "";

        if (checkNoSignleDigit(min)) {
          webinarDurationInString.value =
              "0" + min.toString() + ":" + sec.toString() + "";
        }
        if (checkNoSignleDigit(sec)) {
          if (checkNoSignleDigit(min)) {
            webinarDurationInString.value =
                "0" + min.toString() + ":0" + sec.toString() + "";
          } else {
            webinarDurationInString.value =
                min.toString() + ":0" + sec.toString() + "";
          }
        }
        webinarDurationInSec = webinarDurationInSec + 1;
      },
    );
  }

  void stopWatchTimer() {
    if (webinarTimer != null) {
      webinarTimer.cancel();
    }
  }
}

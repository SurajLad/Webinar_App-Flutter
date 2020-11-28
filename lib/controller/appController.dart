import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:xbsl_task/Helpers/constants.dart';
import 'package:xbsl_task/model/webinar.dart';

class AppController extends GetxController {
  FirebaseApp app;
  FirebaseDatabase database;
  List<Webinar> onGoiningWebinarList = [];

  @override
  void onInit() {
    super.onInit();
  }

  getOngoingWebinar() async {
    onGoiningWebinarList.clear();
    var allWebinars = await database.reference().child(WEBINAR).once();

    print(allWebinars.value);
    if (allWebinars.value != null) {
      allWebinars.value.forEach((key, value) {
        onGoiningWebinarList.add(new Webinar(
          name: value[NAME],
          creatorName: value[CREATOR],
          dateTime: value[DATETIME],
          code: value[CODE],
        ));
      });
    }
    update();
  }
}

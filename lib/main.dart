import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbsl_task/UI/home_page.dart';
import 'package:xbsl_task/controller/appController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppController appController = Get.put(AppController());

  final FirebaseApp app = await Firebase.initializeApp(
    name: 'db2',
    options: FirebaseOptions(
      appId: '1:182761136001:android:66b1878252f2663b305280',
      apiKey: 'AIzaSyDlEE3UZv_cz-UaLoJRe0OtrhvW1llMq_w',
      messagingSenderId: '182761136001',
      projectId: 'ezwebinar',
      databaseURL: 'https://ezwebinar.firebaseio.com',
    ),
  );
  appController.app = app;
  appController.database = FirebaseDatabase(app: app);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EZ Webinars',
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: HomePage(),
    );
  }
}

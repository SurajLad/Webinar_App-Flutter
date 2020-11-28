import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xbsl_task/Helpers/text_styles.dart';
import 'package:xbsl_task/UI/Dialogs/create_webinar.dart';
import 'package:xbsl_task/UI/Dialogs/join_webinar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1E78),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 60, left: 30),
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "EZ Webinars",
                  style: largeTxtStyle.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Text(
                  "Hosting an Webinar made easy",
                  style: largeTxtStyle.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                children: [
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: FlatButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) {
                                return CreateWebinarDialog();
                              });
                        },
                        child: Row(
                          children: [
                            Flexible(
                              flex: 5,
                              child: Image.asset(
                                "assets/create.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Host Webinar",
                                    style: midBoldTxtStyle.copyWith(
                                        color: const Color(0xFF1A1E78)),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "create your own webinar and get invite viewers.",
                                    style: regularTxtStyle.copyWith(
                                        color: const Color(0xFF1A1E78)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 2,
                        margin: const EdgeInsets.all(20),
                        color: const Color(0xFF1A1E78)),
                  ),
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: FlatButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) {
                                return JoinWebinarScreen();
                              });
                        },
                        child: Row(
                          children: [
                            Flexible(
                              flex: 5,
                              child: Image.asset(
                                "assets/join.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Join Webinar",
                                    style: midBoldTxtStyle.copyWith(
                                        color: const Color(0xFF1A1E78)),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Join a webinar by its invite code.",
                                    style: regularTxtStyle.copyWith(
                                        color: const Color(0xFF1A1E78)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1A1E78),
        child: Icon(Icons.thumb_up_alt_outlined),
        onPressed: () {
          Get.snackbar("For Demo - XBSL ",
              "More Stability and Feature Coming soon - Suraj Lad",
              backgroundColor: Colors.white,
              colorText: Color(0xFF1A1E78),
              snackPosition: SnackPosition.BOTTOM);
        },
      ),
    );
  }
}

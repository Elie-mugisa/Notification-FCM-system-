// ignore_for_file: unused_local_variable

import 'package:e_valve/controllers/notification_controller.dart';
import 'package:e_valve/pages/notification_page.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationController = NotificationController.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text('H O M E'),
        actions: [
          GestureDetector(
            onTap: () {
              if (notificationController.notificationsList.isNotEmpty) {
                Get.to(
                  () => NotificationPage(),
                );
              }
            },
            child: Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(right: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.notifications,
                    size: 34,
                    color: Colors.grey.shade500,
                  ),
                  Positioned(
                      top: 2,
                      right: 5,
                      child: Obx(
                        () => Container(
                            height: 16,
                            width: 16,
                            padding: const EdgeInsets.only(bottom: 3),
                            decoration: BoxDecoration(
                                color: notificationController
                                        .notificationsList.isNotEmpty
                                    ? Colors.red
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20)),
                            child:
                                // ignore: prefer_is_empty
                                notificationController
                                            .notificationsList.length >
                                        0
                                    ? Center(
                                        child: Text(
                                          '${notificationController.notificationsList.length}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        ),
                                      )
                                    : null),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Text(
          'H O M E',
          style: TextStyle(
              color: Colors.blue, fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

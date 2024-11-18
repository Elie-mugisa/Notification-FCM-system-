// ignore_for_file: avoid_print, unused_local_variable

import 'package:e_valve/controllers/notification_controller.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // var message = Get.arguments as RemoteMessage;
    final heightPage = MediaQuery.of(context).size.height;
    final widthPage = MediaQuery.of(context).size.width;

    // print('This is the title ${message.notification?.title.toString()}');
    // print(message.notification?.body.toString());
    // print(message.data);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Notification',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: GetBuilder<NotificationController>(
            init: NotificationController(),
            builder: (controller) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                child: Column(
                  children: [
                    ListView.separated(
                      itemCount: controller.notificationsList.length,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey.shade200,
                      ),
                      itemBuilder: (context, index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: heightPage * 0.1,
                              width: widthPage * 0.3,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Center(
                                child: Icon(
                                  Icons.photo,
                                  size: 40,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${controller.notificationsList[index].title}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${controller.notificationsList[index].body}',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        );
                      },
                    )
                  ],
                ),
              );
            }));
  }
}

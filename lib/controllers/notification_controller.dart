import 'package:e_valve/models/notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  static NotificationController get instance => Get.find();

  final List _listNotification = <NotificationModel>[].obs;
  final watcher = 0.obs;

  List get notificationsList => _listNotification;

  void addNotification(RemoteMessage? message) {
    _listNotification.add(NotificationModel(
        title: message!.notification!.title.toString(),
        body: message.notification!.body.toString()));

    update();
  }
}

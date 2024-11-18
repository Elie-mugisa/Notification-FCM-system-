import 'package:e_valve/api/firebase_api.dart';
import 'package:e_valve/app.dart';
import 'package:e_valve/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FireBaseApi().initNotifications();

  runApp(App());
}

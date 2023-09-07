import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:walaa_customer/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/preferences/preferences.dart';
import 'package:walaa_customer/injector.dart' as injector;
import 'dart:async';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'app_bloc_observer.dart';
import 'core/utils/restart_app_class.dart';
import 'firebase_options.dart';
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(
      android: AndroidInitializationSettings('ic_launcher'),
      iOS: IOSInitializationSettings(),
    ),
  );
  await requestPermissions();
  NotificationDetails notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      'channel_description',
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
  );
  Future<void> showNotification(String title, String body) async {
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: 'payload',
    );
  }
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    showNotification(message.data['title'], message.data['body']);

  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    showNotification(message.data['title'], message.data['body']);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    showNotification(message.data['title'], message.data['body']);

  });
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE).then((value) {
  //
  //   print('************');
  //   print(value);
  //   print('************');
  //
  // });
  await injector.setup();
  Bloc.observer =AppBlocObserver();
  runApp(Phoenix(child:  WalaaCustomer()));}
  Future<void> requestPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );}

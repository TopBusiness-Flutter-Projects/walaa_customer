import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:walaa_customer/app.dart';
import 'package:flutter/material.dart';
import 'feature/orders/cubit/order_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/core/preferences/preferences.dart';
import 'package:walaa_customer/injector.dart' as injector;
import 'dart:async';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'app_bloc_observer.dart';
import 'config/routes/app_routes.dart';
import 'core/utils/restart_app_class.dart';
import 'feature/navigation_bottom/cubit/navigator_bottom_cubit.dart';
import 'firebase_options.dart';
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
NotificationDetails notificationDetails = NotificationDetails(
  android: AndroidNotificationDetails(
    'channel_id',
    'channel_name',

    importance: Importance.high,
    priority: Priority.high,
  ),
  iOS: DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  ),
);

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  showNotification(message.data['title'], message.data['body'],message.data['order_id']);

}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(
      android: AndroidInitializationSettings('ic_launcher'),
      iOS: DarwinInitializationSettings( onDidReceiveLocalNotification: ondidnotification),
    ),
      onDidReceiveNotificationResponse: onSelectNotification,
      onDidReceiveBackgroundNotificationResponse: onSelectNotification
  );
  await requestPermissions();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    showNotification(message.data['title'], message.data['body'],message.data['order_id']);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    showNotification(message.data['title'], message.data['body'],message.data['order_id']);

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

Future onSelectNotification(NotificationResponse details) async {
  print("object");
  print("object");
  Preferences.instance.getSavedLang().then((value) =>{
    Get.context!.read<OrderCubit>().setlang(value)

  });
  Get.context!.read<OrderCubit>().getUserData().then((value) => Get.context!.read<OrderCubit>(). getorders(value));

  Navigator.pushNamed(
      Get.context!, Routes.ordersRoute);
}

Future ondidnotification(
    int id, String? title, String? body, String? payload) async {
  print("object");
  Preferences.instance.getSavedLang().then((value) =>{
    Get.context!.read<OrderCubit>().setlang(value)

  });
  Get.context!.read<OrderCubit>().getUserData().then((value) =>  Get.context!.read<OrderCubit>().getorders(value));

  Navigator.pushNamed(
      Get.context!, Routes.ordersRoute);}

Future<void> showNotification(String title, String body,String order_id) async {
  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    notificationDetails,
    payload: order_id,
  );
}

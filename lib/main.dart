import 'package:firebase_core/firebase_core.dart';
import 'package:walaa_customer/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walaa_customer/injector.dart' as injector;
import 'dart:async';


import 'app_bloc_observer.dart';
import 'core/utils/restart_app_class.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await injector.setup();
  Bloc.observer =AppBlocObserver();
  runApp(HotRestartController(child:  WalaaCustomer()));
}
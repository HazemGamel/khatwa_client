import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/uitils/bloc_observer.dart';
import 'core/uitils/service_locator.dart';
import 'firebase_options.dart';
import 'core/functions/location.dart';
import 'core/helper/notifictions_helper.dart';
import 'core/services/cache_storage_services.dart';
import 'dart:io';
import '../core/class/http_override.dart';
import 'package:bloc/bloc.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheStorageServices.init();
  requestPermissionLocation();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HttpOverrides.global = MyHttpOverrides();
  String ? tok = await FirebaseMessagingService.getDeviceToken();
  print("device token ${tok}");
  setupOrientation();
  await Firebase.initializeApp(options:
  DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  setupServiceLocator();
  runApp(const SeliveryClient());
}

void setupOrientation() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

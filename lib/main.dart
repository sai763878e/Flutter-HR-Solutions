import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'app.dart';
import 'data/repositories/authentication/authentication_repository.dart';

import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path/path.dart';
import 'dart:io';

Future<void> main() async {
  //Add Widgets binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Init Local Storage
  await GetStorage.init();
  //Todo: Await Native Splash
  //Todo: Init Firebase
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));
  //TOdo: Init Authentication

  //Todo:Init Database
  // await openDatabaseFromAsset()
  //     .then((value) => Get.put(AuthenticationRepository()));



  runApp(const MyApp());
}


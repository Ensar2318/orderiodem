import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:zwerge/screens/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // initialize the Intercom.
  // make sure to add keys from your Intercom workspace.
  await Intercom.instance.initialize('hb23av22',
      iosApiKey: 'ios_sdk-33c28cb318d7c7c95671221cb845a84f3db86495', androidApiKey: 'android_sdk-018d1f3960a5258e39b51cb7c38880bf1139dc70');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = MyHttpOverrides();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black, // navigation bar color
        statusBarColor: Colors.black,
        statusBarBrightness: Brightness.dark // status bar color
        ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '7zwerge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: Colors.white,
      ),
      home: const Splash(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

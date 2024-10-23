import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:quran/directory/splashscreen.dart';
import 'package:sizer/sizer.dart';

import 'directory/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //Get.lazyPut(() => const ReadingScreen());
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: MyTheme.lighttheme,
        darkTheme: MyTheme.darktheme,
        home: const SplashScreen(),
      );
    });
  }
}


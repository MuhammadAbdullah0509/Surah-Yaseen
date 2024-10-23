import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../screens/menu.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      await Get.off(() => const MenuScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("images/Splash-background.png"),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Image.asset(
                "images/Splash-Icon.png",
                alignment: Alignment.center,
                width: 100.h,
                color: Theme.of(context).primaryColor,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    });
  }
}

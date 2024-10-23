import 'package:quran/screens/reciters.dart';
import 'package:quran/screens/translationscreen.dart';
import 'package:quran/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../adds_integration/bannerads.dart';
import '../managers/settingmanager.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final SettingManager _settingManager = SettingManager();
  String reciterName = "";
  String translationName = "";

  @override
  void initState() {
    super.initState();
    getLocal().whenComplete(() {
      setState(() {});
    });
  }

  //get from local storage
  Future<void> getLocal() async {
    reciterName = await _settingManager.getReciterName();
    translationName = await _settingManager.getTranslationName();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return WillPopScope(
        onWillPop: () async {
          Get.back(result: 'refresh');
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Settings"),
            centerTitle: true,
            backgroundColor: Styles.appbar,
          ),
          body: Container(
            decoration: const BoxDecoration(),
            child: Column(
              children: [
                listview(),
            const BannerAds(),
              ],
            ),
          ),
        ),
      );
    });
  }

  listview() {
    return Expanded(
      child: ListView(
        children: [
          listTiles("Reciter", reciterName),
          listTiles("Translation", translationName),
        ],
      ),
    );
  }

  listTiles(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListTile(
        //tileColor: Colors.white,
        leading: Text(
          title,
          style: Styles.size18,
        ),
        title: Text(
          subtitle,
          textAlign: TextAlign.end,
        ),
        shape: const Border(bottom: BorderSide(color: Colors.black)),
        trailing: const Icon(Icons.arrow_forward_ios),
        autofocus: false,
        selected: false,
        onTap: () async {
          if (title == "Reciter") {
            final result = await Get.to(const ReciterScreen());
            if (result != null) {
              setState(() {
                getLocal();
              });
            }
          }
          if (title == "Translation") {
            final result = await Get.to(const TranslationScreen());
            if (result != null) {
              setState(() {
                getLocal();
              });
            }
          }
        },
      ),
    );
  }
}

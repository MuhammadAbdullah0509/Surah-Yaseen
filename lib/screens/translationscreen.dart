import 'package:flutter/material.dart';
//import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

//import '../adds_integration/bannerads.dart';
import '../managers/settingmanager.dart';
import '../styles.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  final SettingManager _settingManager = SettingManager();
  bool isSelected = false;
  Map<int, bool> selectTile = {};
  String translatorName = "";
  List name = ['Urdu','English'];

  Future<void> prefetchInformation() async {
    await getLocal();
  }

  @override
  void initState() {
    super.initState();
    prefetchInformation().whenComplete(() {
      setState(() {});
      print("DATA loaded");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, orientation, deviceType) {
      return WillPopScope(
        onWillPop: () async {
          saveLocal();
          Get.back(result: 'refresh');
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Translation"),
            centerTitle: true,
            backgroundColor: Styles.appbar,
          ),
          body: Container(
            decoration: const BoxDecoration(),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      //const Gap(5),
                      Styles.searchBox(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Selected Translation",
                          style:
                              Styles.size18.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      for (int i = 0; i < name.length; i++) listTiles(i),
                    ],
                  ),
                ),
                //const BannerAds(),
              ],
            ),
          ),
        ),
      );
    }),);
  }

  listTiles(index) {
    return ListTile(
      title: Text(
        "${name[index]}",
        style: const TextStyle(fontSize: 20.0),
      ),
      shape: const Border(bottom: BorderSide(color: Colors.black)),
      trailing: translatorName == name[index] ? const Icon(Icons.done) : null,
      onTap: () {
        isSelected = true;
        onTap(isSelected, index);
        translatorName = name[index];
      },
    );
  }

  onTap(bool isSelected, int i) {
    if (isSelected) {
      setState(() {
        selectTile[i] = true;
      });
    }
  }

//save from local storage
  Future<void> saveLocal() async {
    _settingManager.saveTranslationName(translatorName);
  }

  //get from local storage
  Future<void> getLocal() async {
    translatorName = await _settingManager.getTranslationName();
  }
}

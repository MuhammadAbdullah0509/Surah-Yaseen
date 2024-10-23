import 'package:quran/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
//import '../adds_integration/bannerads.dart';
import '../managers/settingmanager.dart';

class ReciterScreen extends StatefulWidget {
  const ReciterScreen({super.key});

  @override
  State<ReciterScreen> createState() => _ReciterScreenState();
}

class _ReciterScreenState extends State<ReciterScreen> {
  final SettingManager _settingManager = SettingManager();

  @override
  void initState() {
    super.initState();
    getLocal().whenComplete(() {
      setState(() {});
    });
  }

  String reciterName = "";
  bool isSelected = false;
  Map<int, bool> selectTile = {};
  List name = [
    'Abdul Samad',
  ];

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
              title: const Text("Reciter"),
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
                        const Gap(5),
                        Styles.searchBox(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Select Reciter",
                            style: Styles.size18
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Gap(5),
                        for (int i = 0; i < name.length; i++) listTiles(i),
                      ],
                    ),
                  ),
                 // const BannerAds(),
                ],
              ),
            )),
      );
    }));
  }

  listTiles(index) {
    return ListTile(
      shape: const Border(bottom: BorderSide(color: Colors.black)),
      title: Text("${name[index]}", style: const TextStyle(fontSize: 20.0)),
      trailing: reciterName == name[index] ? const Icon(Icons.done) : null,
      onTap: () {
        isSelected = true;
        onTap(isSelected, index);
        reciterName = name[index];
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

  Future<void> saveLocal() async {
    await _settingManager.saveReciterName(reciterName.toString());
  }

  //get from local storage
  Future<void> getLocal() async {
    reciterName = await _settingManager.getReciterName();
  }
}

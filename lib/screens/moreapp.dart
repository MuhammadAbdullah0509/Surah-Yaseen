// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
//import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../adds_integration/bannerads.dart';
import '../adds_integration/interstitialads.dart';
import '../styles.dart';

class moreApps extends StatefulWidget {
  const moreApps({super.key});

  @override
  State<moreApps> createState() => _moreAppsState();
}

class _moreAppsState extends State<moreApps> {
  TextEditingController textController = TextEditingController();
  final InterstitialAds add = InterstitialAds();
  bool moreApp = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //showAds();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return WillPopScope(
        onWillPop: () async {
         // Get.back(result: 'result');
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text("More App"),
              centerTitle: true,
              backgroundColor: Styles.appbar,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Stack(
                        children: [
                          Styles.searchBox(),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Column(
                        children: [
                          drawWidgets(),
                        ],
                      ),
                      //const Gap(2),
                      Column(
                        children: [
                         // drawWidgets(),
                        ],
                      ),
                     //const Gap(6),
                      moreApp == true
                          ? const Align(
                              alignment: Alignment.bottomCenter,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ))
                          : const Center(child: Text("")),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  moreApp = true;
                                  //add.show();
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).dialogBackgroundColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              child: Text(
                                "More Apps",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Theme.of(context).highlightColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
               // const BannerAds(),
              ],
            )),
      );
    });
  }

  drawWidgets() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).shadowColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.15, // 15% of screen height
                width: double.infinity,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("images/quran.jpg"),
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).shadowColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: SizedBox(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.15, // 15% of screen width
                          width: MediaQuery.of(context).size.width * 0.15, // 15% of screen width
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.rectangle,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).focusColor, //color of shadow
                                spreadRadius: 3, //spread radius
                                blurRadius: 0, // blur radius
                                offset: const Offset(0, 2), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.15, // 15% of screen width
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Styles.white,
                                image: const DecorationImage(
                                  image: AssetImage("images/quran.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //const Gap(2),
                       Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Qibla Connect Find Direction",
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.04, // 4% of screen width
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0),
                              child: Row(
                                children: [
                                  Text(
                                    "LifeStyle",
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.04, // 4% of screen width
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0),
                              child: Row(
                                children: [
                                  Text(
                                    "4.3",
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.03, // 3% of screen width
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.star),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "64  MB",
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.03, // 3% of screen width
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  showAds() {
    //add.iniAd();
    setState(() {});
  }
}


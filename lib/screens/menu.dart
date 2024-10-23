
import 'package:get/get.dart';
import 'package:quran/screens/player.dart';
import 'package:quran/screens/surahpdf.dart';
import 'package:quran/styles.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../adds_integration/bannerads.dart';
import 'moreapp.dart';


class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool ads = true;
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/Splash-background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20, top: 20, left: 30, right: 30),
                    child: SizedBox(
                      height: 16.h,
                      child: Image.asset(
                        "images/Splash-Icon.png",
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          drawWidgets("images/book.png", "Read & Listen"),
                        ],
                      ),
                      Column(
                        children: [drawWidgets("images/pdf.png", "Pdf")],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          drawWidgets("images/share.png", "Share App")
                        ],
                      ),
                      Column(
                        children: [drawWidgets("images/star.png", "Rate")],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          drawWidgets("images/square.png", "More App")
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: BannerAds(),
              ),
            ],
          ),
        ),
      );
    });
  }

  drawWidgets(String image, String title) {
    return SizedBox(
      height: 22.h,
      width: 22.h,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GestureDetector(
          onTap: () async {
            print(title);
            if (title == "Read & Listen") {
              final result = await Get.to(() => const ReadingScreen());
              //Navigator.push(context, MaterialPageRoute(builder: (context) => ReadingScreen()));
            }
            if (title == "More App") {
              final result = await Get.to(const moreApps());
            }
            if (title == "Rate") {
              ratings();
            }
            if (title == "Pdf") {
              final result = await Get.to(() => (const SurahPdf()));
            }
            if (title == 'Share App') {
              Share.share('My App Link ');
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color:  Theme.of(context).dialogBackgroundColor,//Theme.of(context).elevatedButtonTheme, //backgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage(image),
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  Text(
                    title,
                    style: Styles.size18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ratings() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.bottomCenter,
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).dialogBackgroundColor,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    height: 20.h,
                    width: 150.w,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Rate App", style: Styles.size18),
                        ),
                        RatingBar.builder(
                          minRating: 0,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Theme.of(context).canvasColor,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 8.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).dialogBackgroundColor,
                        foregroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: Styles.size18
                            .copyWith(color: Colors.blueAccent, fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

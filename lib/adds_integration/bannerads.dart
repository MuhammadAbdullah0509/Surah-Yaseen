import 'package:flutter/material.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sizer/sizer.dart';
import 'dart:io' show Platform;

import 'ads_ids.dart';

class BannerAds extends StatefulWidget {
  const BannerAds({Key? key}) : super(key: key);

  @override
  State<BannerAds> createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> {
  // late BannerAd bannerAd;
  // late AdRequest adRequest;
  String? bannerId = "";
  final AdsIds _adsIds = AdsIds();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //loadBannerAdd();
  }

  // loadBannerAdd() {
  //   bannerId = Platform.isAndroid?_adsIds.bannerAndroidId():_adsIds.bannerIosId();
  //   adRequest = const AdRequest(
  //     nonPersonalizedAds: false,
  //   );
  //   BannerAdListener bannerAdListener = BannerAdListener(onAdClosed: (ad) {
  //     bannerAd.load();
  //   }, onAdFailedToLoad: (ad, error) {
  //     bannerAd.load();
  //   });
  //   bannerAd = BannerAd(
  //     size: AdSize.fullBanner,
  //     adUnitId: bannerId!,
  //     listener: bannerAdListener,
  //     request: adRequest,
  //   );
  //   bannerAd.load();
  // }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context,orientation,deviceType){
      return Container(
        height: 57,
       // child: AdWidget(ad: bannerAd,),
      );
    },);
  }
}

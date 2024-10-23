import 'package:quran/adds_integration/ads_ids.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;

class InterstitialAds {
  //late InterstitialAd interstitialAd;
  bool isLoaded = false;
  //late AdRequest adRequest;
  final AdsIds _adsIds = AdsIds();

  void iniAd() {
  //  adRequest = const AdRequest(
      //nonPersonalizedAds: false,
    //);
    // InterstitialAd.load(
    //   adUnitId: Platform.isAndroid
    //       ? _adsIds.interstitialIdAndroid()
    //       : _adsIds.interstitialIdIos(),
    //   request: const AdRequest(),
    //   adLoadCallback: InterstitialAdLoadCallback(
    //     onAdLoaded: (ad) {
    //       interstitialAd = ad;
    //       isLoaded = true;
    //     },
    //     onAdFailedToLoad: (error) {
    //       print(error.message);
    //     },
    //   ),
    //);
  }

  show() {
    //interstitialAd.show();
  }
}

import 'dart:convert';
import 'package:quran/screens/Setting.dart';
import 'package:quran/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter/services.dart' as root;
import '../adds_integration/bannerads.dart';
import '../jsonfile/Surah.dart';
import '../managers/settingmanager.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class ReadingViewModel {
  bool play = false;
  bool playing = false;
  bool looping = false;

  Surah? surahData;
  String? reciter = "";
  String? translator = "";
  String? audioPath = "";

  int listenerIndex = 0;
  int currentAudioIndex = 0;
  int goToIndex = 0;

  int totalAyt() {
    return surahData?.totalVerses ?? 0;
  }

  String currentReciter() {
    return reciter ?? "";
  }

  String currentTranslation() {
    return translator ?? "";
  }

  Future<void> jsonData() async {
    var res = await root.rootBundle.loadString('lib/jsonfile/Yaseen.json');
    Map<String, dynamic> user = jsonDecode(res);
    surahData = Surah.fromJson(user);
  }
}

class _ReadingScreenState extends State<ReadingScreen> {
  final AssetsAudioPlayer _player = AssetsAudioPlayer();
  final ReadingViewModel _viewModel = ReadingViewModel();
  final SettingManager _settingManager = SettingManager();

  final TextEditingController searchController = TextEditingController();
  ItemScrollController downController = ItemScrollController();
  ItemPositionsListener positionsListener = ItemPositionsListener.create();

  Future<void> prefetchInformation() async {
    await getLocal();
    await _viewModel.jsonData();
    await loadAudio();
  }

  void _stopPlayer() async {
    _viewModel.play = false;
    _viewModel.playing = false;
    await _player.stop();
  }

  @override
  void initState() {
    super.initState();
    prefetchInformation().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return WillPopScope(
        onWillPop: () async {
          _stopPlayer();
          Get.back(result: 'refresh');
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Surah Yaseen",
            ),
            centerTitle: true,
            backgroundColor: Styles.appbar,
            actions: [
              TextButton(
                onPressed: () async {
                  stop();
                  final result = await Get.to(const SettingScreen());
                  setState(() {
                    if (result != null) {
                      prefetchInformation();
                    }
                  });
                },
                child: Image.asset("images/icons8-settings-50.png",
                    filterQuality: FilterQuality.high),
              )
            ],
          ),
          body: Stack(
            children: [
              ListView(
                children: [
                  Container(
                    color: Styles.appbar,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        _viewModel.currentReciter(),
                        style: Styles.size18.copyWith(color: Colors.white),
                      ),
                    )),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  jsonViewer(),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 60.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BannerAds(),
                  ],
                ),
              ),
              //bottom container
              bottomContainer(),
            ],
          ),
        ),
      );
    });
  }

  jsonViewer() {
    _player.playlistAudioFinished.listen((event) {
      if (downController.isAttached &&
          _viewModel.listenerIndex == _viewModel.currentAudioIndex &&
          _viewModel.looping == false) {
        downController.scrollTo(
            index: event.index + 1, duration: const Duration(microseconds: 50));
      }
    });
    _player.current.listen((playingAudio) {
      if (mounted) setState(() {});
    });
    _viewModel.playing == true
        ? indexChange(_player.getCurrentAudioTitle)
        : null;
    return SizedBox(
      height: 75.h,
      child: ScrollablePositionedList.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: _viewModel.surahData?.verses.length.toInt() ?? 0,
          itemScrollController: downController,
          itemPositionsListener: positionsListener,
          itemBuilder: (context, int index) {
            if (_viewModel.currentAudioIndex == _viewModel.totalAyt()) {
              _player.playlistAudioFinished.listen((event) {
                setState(() {
                  _stopPlayer();
                });
              });
            }
            positionsListener.itemPositions.addListener(() {
              _viewModel.listenerIndex =
                  positionsListener.itemPositions.value.first.index + 1;
            });
            return Column(
              children: [
                Container(
                  color: _viewModel.surahData!.verses[index].id ==
                              _viewModel.currentAudioIndex ||
                          _viewModel.surahData!.verses[index].id ==
                              _viewModel.goToIndex
                      ? Colors.blue.shade200
                      : Theme.of(context).shadowColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Center(
                                            child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          (_viewModel.surahData!.verses[index]
                                                  .text ??
                                              "Empty value"),
                                          style: Styles.size18.copyWith(
                                              fontFamily: 'fontfamily'),
                                          textAlign: TextAlign.center),
                                    ))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: _viewModel.translator == "Urdu"
                                              ? Text(
                                                  _viewModel.surahData!
                                                      .verses[index].urdu,
                                                  style: Styles.size18.copyWith(
                                                      fontSize: 16,
                                                      fontFamily: 'fontfamily'),
                                                  textAlign: TextAlign.center,
                                                )
                                              : Text(
                                                  _viewModel.surahData!
                                                      .verses[index].english,
                                                  style: Styles.size18.copyWith(
                                                      fontSize: 16,
                                                      fontFamily: 'fontfamily'),
                                                  textAlign: TextAlign.center,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Theme.of(context).cardColor,
                                  child: Text(
                                      _viewModel.surahData!.verses[index].id
                                          .toString(),
                                      style: Styles.size18.copyWith(
                                          fontSize: 14,
                                          fontFamily: 'fontfamily',
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Gap(2.h),
              ],
            );
          }),
    );
  }

  //bottomPlayer Controller
  bottomContainer() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Styles.appbar,
        height: 10.h,
        width: 100.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            animatedIcon();
                          },
                          icon: Icon(
                            _viewModel.playing != false
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 30,
                            color: Styles.white,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            loopAudio();
                          },
                          icon: Icon(
                            _viewModel.looping != true
                                ? Icons.repeat
                                : Icons.repeat_one,
                            size: 30,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          stop();
                        },
                        icon: Icon(
                          Icons.square,
                          size: 30,
                          color: Styles.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.h,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          aytSearch();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                        ),
                        child: Text(
                          "Goto",
                          style: Styles.size18.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  aytSearch() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text("Go to Ayt Number"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context)
                        .elevatedButtonTheme
                        .style
                        ?.backgroundColor
                        ?.resolve({}) ??
                    Theme.of(context)
                        .colorScheme
                        .primary, //Theme.of(context).backgroundColor,
                foregroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              child: Text(
                "Cancel",
                style: TextStyle(
                    fontSize: 16.0, color: Theme.of(context).cardColor),
              ),
            ),
            ElevatedButton(
              onPressed: () async{
                Navigator.of(context).pop(searchController.text);
                setState(() async {
                  _viewModel.goToIndex = int.parse((searchController.text));
                  if (_viewModel.goToIndex <=
                      _viewModel.surahData!.totalVerses) {
                    _viewModel.currentAudioIndex = _viewModel.goToIndex;
                    _viewModel.audioPath = _viewModel.reciter?.replaceAll(' ', '');
                    List<Audio> audioList = [];
                    for (int index = 1; index <= _viewModel.totalAyt(); index++) {
                      audioList.add(Audio('Reciters/${_viewModel.audioPath}/$index.mp3',
                          metas: Metas(title: index.toString(), id: index.toString())));
                    }
                    await _player.open(
                      Playlist(startIndex: _viewModel.goToIndex-1, audios: audioList),
                      autoStart: false,
                    );
                    scroll(_viewModel.goToIndex);
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Styles.appbar,
                foregroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              child: Text(
                "Ok",
                style: TextStyle(
                    fontSize: 16.0, color: Theme.of(context).primaryColorLight),
              ),
            ),
          ],
          content: SizedBox(
            height: 11.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Enter Ayt Number"),
                TextFormField(
                  controller: searchController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText:
                        "Enter Ayt number from 1 to ${_viewModel.surahData!.totalVerses}",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void animatedIcon() {
    setState(() {
      _viewModel.playing = !_viewModel.playing;
      if (_viewModel.playing) {
        _viewModel.play = true;
        _player.play();
      } else {
        _viewModel.playing = false;
        _viewModel.play = false;
        _player.pause();
      }
    });
  }

  void loopAudio() async {
    setState(() {
      _viewModel.looping = !_viewModel.looping;
    });
    if (_viewModel.looping) {
      _player.setLoopMode(LoopMode.single);
    } else {
      _player.setLoopMode(LoopMode.none);
    }
  }

  void stop() {
    setState(() {
      _stopPlayer();
      _viewModel.currentAudioIndex = 0;
      _viewModel.listenerIndex = -1;
      downController.jumpTo(index: _viewModel.listenerIndex + 1);
      prefetchInformation();
    });
  }

  Future scroll(no) async {
    _viewModel.play = false;
    move(no);
  }

  Future move(int a) async {
    downController.scrollTo(
        index: a - 1, duration: const Duration(milliseconds: 500));
  }

  /// Helper functions
  //get from local storage
  Future<void> getLocal() async {
    _viewModel.reciter = await _settingManager.getReciterName();
    _viewModel.translator = await _settingManager.getTranslationName();
  }

  loadAudio() {
    _viewModel.audioPath = _viewModel.reciter?.replaceAll(' ', '');
    print(_viewModel.audioPath);
    List<Audio> audioList = [];
    for (int index = 1; index <= _viewModel.totalAyt(); index++) {
      audioList.add(Audio('Reciters/${_viewModel.audioPath}/$index.mp3',
          metas: Metas(title: index.toString(), id: index.toString())));
    }
    _player.open(
      Playlist(startIndex: 0, audios: audioList),
      autoStart: false,
    );
  }

  indexChange(i) {
    _viewModel.currentAudioIndex = int.parse(i);
  }
}

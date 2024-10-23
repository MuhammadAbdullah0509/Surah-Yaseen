// //pin player class on every screen and it is not used any where.
// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:quran/screens/player.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../styles.dart';
//
// class PlayerClass extends StatefulWidget {
//   const PlayerClass({Key? key}) : super(key: key);
//
//   @override
//   State<PlayerClass> createState() => _PlayerClassState();
// }
//
// class _PlayerClassState extends State<PlayerClass> {
//   bool looping = false;
//   @override
//   Widget build(BuildContext context) {
//     return Sizer(builder: (context,orientation,deviceType){
//       return audio.stick==true?pinPlayer():const Text("");
//     });
//   }
//   pinPlayer() {
//     return Center(
//       child: Align(
//         alignment: Alignment.bottomCenter,
//         child: Container(
//           decoration: BoxDecoration(
//             color: Styles.appbar,
//           ),
//           height: 11.h,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     IconButton(
//                       onPressed: () async {
//                         animatedIcon();
//
//                       },
//                       icon: Styles.playing != false
//                           ? Icon(
//                         Icons.pause,
//                         size: 28.0,
//                         color: Styles.white,
//                       )
//                           : Icon(
//                         Icons.play_arrow,
//                         size: 28.0,
//                         color: Styles.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         loopAudio();
//                       },
//                       icon: looping != true
//                           ? const Icon(
//                         Icons.repeat,
//                         size: 28.0,
//                       )
//                           : const Icon(
//                         Icons.repeat_one,
//                         size: 28.0,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                          stop();
//                       },
//                       icon: Icon(
//                         Icons.square,
//                         size: 28.0,
//                         color: Styles.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   animatedIcon() {
//     setState(() {
//       Styles.playing = !Styles.playing;
//       if (Styles.playing) {
//         audio.play = true;
//         Players.player.play();
//
//       } else {
//         audio.play = false;
//         Players.player.pause();
//       }
//     });
//   }
//   void loopAudio() async {
//     setState(() {
//       looping = !looping;
//     });
//     if (looping) {
//       Players.player.setLoopMode(LoopMode.single);
//     } else {
//       Players.player.setLoopMode(LoopMode.none);
//     }
//   }
//   void stop() {
//     Players.player.stop();
//     setState(() {
//       Styles.playing = false;
//       audio.play=false;
//       audio.stick=false;
//     });
//   }
// }
//

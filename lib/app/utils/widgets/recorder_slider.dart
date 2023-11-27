// import 'dart:async';
// import 'dart:io' as io;
//
// import 'package:audioplayers/audioplayers.dart';
// import 'package:file/file.dart';
// import 'package:file/local.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
// // import 'package:another_audio_recorder/another_audio_recorder.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:fitmint_flutter/app/utils/color_helper.dart';
// import 'package:fitmint_flutter/app/utils/sizer.dart';
// import 'package:fitmint_flutter/app/utils/string_helper.dart';
// import 'package:path_provider/path_provider.dart';
//
// class RecorderSlider extends StatefulWidget {
//   final LocalFileSystem localFileSystem;
//   TextEditingController discController;
//
//   RecorderSlider({localFileSystem, required this.discController})
//       : this.localFileSystem = localFileSystem ?? LocalFileSystem();
//
//   @override
//   State<StatefulWidget> createState() => new RecorderSliderState();
// }
//
// class RecorderSliderState extends State<RecorderSlider> {
//   // AnotherAudioRecorder? _recorder;
//   FlutterAudioRecorder2? _recorder;
//
//   Recording? _current;
//   RecordingStatus _currentStatus = RecordingStatus.Unset;
//   final _focusnode = FocusNode();
//   final key = new GlobalKey();
//   bool isShowRecord = true;
//   bool isAudioRecordStarted = false;
//   bool isAudioRecorded = false;
//
//   int audioFilePosition = -1;
//   AudioPlayer audioPlayer = AudioPlayer();
//   AudioCache audioCache = AudioCache();
//   Duration duration = new Duration();
//   Duration position = new Duration();
//
//   //older audioplayer
//   // AudioPlayerState playerState = AudioPlayerState.STOPPED;
//   // get isPlaying => playerState == AudioPlayerState.PLAYING;
//   // get isPaused => playerState == AudioPlayerState.PAUSED;
//
//   PlayerState playerState = PlayerState.STOPPED;
//
//   get isPlaying => playerState == PlayerState.PLAYING;
//
//   get isPaused => playerState == PlayerState.PAUSED;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: White,
//       body: new Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Container(
//                 height: isAudioRecordStarted && isAudioRecorded
//                     ? 8.h
//                     : isShowRecord
//                         ? 8.h
//                         : 25.h,
//                 padding: EdgeInsets.only(right: 4.w),
//                 child: isAudioRecordStarted
//                     ? recordingSlider()
//                     : isAudioRecorded
//                         ? slider()
//                         : SizedBox.expand(
//                             child: Center(
//                               child: TextField(
//                                 controller: widget.discController,
//                                 textInputAction: TextInputAction.done,
//                                 focusNode: _focusnode,
//                                 onTap: () {
//                                   setState(() {
//                                     isShowRecord = false;
//                                   });
//                                 },
//                                 onChanged: (value) {
//                                   if (value.length == 0) {
//                                     setState(() {
//                                       isShowRecord = true;
//                                     });
//                                   } else {
//                                     setState(() {
//                                       isShowRecord = false;
//                                     });
//                                   }
//                                 },
//                                 maxLines: 4,
//                                 keyboardType: TextInputType.text,
//                                 style: TextStyle(
//                                     decoration: TextDecoration.none,
//                                     color: skipColor,
//                                     fontSize: 16),
//                                 decoration: InputDecoration(
//                                   labelText: 'Write here',
//                                   border: InputBorder.none,
//                                   labelStyle: GoogleFonts.notoSans(
//                                       color: skipColor, fontSize: 18),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: skipColor)),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: skipColor)),
//                                 ),
//                               ),
//                             ),
//                           ),
//               ),
//             ),
//             isShowRecord && !isAudioRecorded
//                 ? TooltipTheme(
//                     data: TooltipThemeData(
//                       decoration: BoxDecoration(
//                         color: backArrawColor,
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                     ),
//                     child: Tooltip(
//                       key: key,
//                       message: "Hold to record",
//                       child: GestureDetector(
//                         child: Image.asset(
//                           isAudioRecordStarted
//                               ? "assets/connect_page/record.png"
//                               : "assets/connect_page/record_blank.png",
//                           height: 35,
//                           width: 22,
//                         ),
//                         onTapCancel: () {
//                           final dynamic tooltip = key.currentState;
//                           tooltip.deactivate();
//                         },
//                         onLongPress: () async {
//                           final dynamic tooltip = key.currentState;
//                           tooltip.deactivate();
//                           FocusScope.of(context).unfocus();
//                           await _init();
//                           setState(() {
//                             isAudioRecordStarted = true;
//                           });
//                           await _start();
//                         },
//                         onLongPressUp: () {
//                           final dynamic tooltip = key.currentState;
//                           tooltip.deactivate();
//                           _currentStatus != RecordingStatus.Unset
//                               ? _stop()
//                               : null;
//                           setState(() {
//                             isAudioRecordStarted = false;
//                             isAudioRecorded = true;
//                           });
//                           initAudioPlayer();
//                         },
//                         onTap: () {
//                           final dynamic tooltip = key.currentState;
//                           tooltip.ensureTooltipVisible();
//                         },
//                       ),
//                       preferBelow: false,
//                       textStyle: GoogleFonts.notoSans(
//                           color: Black,
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500),
//                       margin: EdgeInsets.all(10),
//                       padding: EdgeInsets.all(10),
//                     ),
//                   )
//                 : isAudioRecorded
//                     ? InkWell(
//                         onTap: () {
//                           StringHelper().setRecordedAudioPath(path: "");
//                           setState(() {
//                             isAudioRecorded = false;
//                             duration = Duration();
//                             position = Duration();
//                             audioPlayer = AudioPlayer();
//                           });
//                         },
//                         child: SvgPicture.asset(
//                           "assets/connect_page/delete.svg",
//                         ),
//                       )
//                     : Container(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   slider() {
//     return Container(
//         width: SizerUtil.width * 0.8,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10), color: backArrawColor),
//         child: Row(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 4.w),
//               child: InkWell(
//                 onTap: () {
//                   isPlaying ? pause() : play();
//                 },
//                 child: CircleAvatar(
//                   backgroundColor: endGradientColor,
//                   child: Icon(
//                     isPlaying ? Icons.pause : Icons.play_arrow,
//                     color: White,
//                   ),
//                 ),
//               ),
//             ),
//             SliderTheme(
//               data: SliderThemeData(
//                   trackHeight: 1,
//                   thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5)),
//               child: Slider(
//                   value: position.inMilliseconds.toDouble(),
//                   onChanged: (double value) {
//                     seekToMilliSecond(value.toInt());
//                   },
//                   activeColor: endGradientColor,
//                   inactiveColor: profileTextFieldBorderColor,
//                   min: 0.0,
//                   max: position.inMilliseconds.toDouble() >
//                           duration.inMilliseconds.toDouble()
//                       ? position.inMilliseconds.toDouble()
//                       : duration.inMilliseconds.toDouble()),
//             ),
//             StringHelper.getNotoSansText(
//                 "${duration.inMinutes.toString()}:${duration.inSeconds.toString()}",
//                 color: Black,
//                 fontSize: 15,
//                 font: FontWeight.w500),
//           ],
//         ));
//   }
//
//   recordingSlider() {
//     return Container(
//         width: SizerUtil.width * 0.8,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10), color: backArrawColor),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 4.w),
//               child: CircleAvatar(
//                 minRadius: 10,
//                 maxRadius: 10,
//                 backgroundColor: recordingRedColor,
//               ),
//             ),
//             StringHelper.getNotoSansText("Recording",
//                 color: skipColor, fontSize: 15),
//             Padding(
//               padding: EdgeInsets.only(right: 4.w),
//               child: StringHelper.getNotoSansText(
//                   "${_current!.duration!.inMinutes.toString()}:${_current!.duration!.inSeconds.toString()}",
//                   color: Black,
//                   fontSize: 15,
//                   font: FontWeight.w500),
//             ),
//           ],
//         ));
//   }
//
//   void seekToMilliSecond(int millisecond) {
//     Duration newDuration = Duration(milliseconds: millisecond);
//     audioPlayer.seek(newDuration);
//   }
//
//   _init() async {
//     try {
//       bool hasPermission = await FlutterAudioRecorder2.hasPermissions ?? false;
//
//       if (hasPermission) {
//         String customPath = '/recorded_audio';
//         io.Directory appDocDirectory;
// //        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
//         if (io.Platform.isIOS) {
//           appDocDirectory = await getApplicationDocumentsDirectory();
//         } else {
//           appDocDirectory = (await getExternalStorageDirectory())!;
//         }
//
//         // can add extension like ".mp4" ".wav" ".m4a" ".aac"
//         var audiopath = appDocDirectory.path +
//             customPath +
//             DateTime.now().millisecondsSinceEpoch.toString() +
//             ".aac";
//
//         // .wav <---> AudioFormat.WAV
//         // .mp4 .m4a .aac <---> AudioFormat.AAC
//         // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
//         _recorder =
//             FlutterAudioRecorder2(audiopath, audioFormat: AudioFormat.AAC);
//
//         await _recorder!.initialized;
//         // after initialization
//         var current = await _recorder!.current(channel: 0);
//         await StringHelper().setRecordedAudioPath(path: audiopath);
//         // should be "Initialized", if all working fine
//         setState(() {
//           _current = current;
//           _currentStatus = current!.status!;
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: new Text("You must accept permissions")));
//       }
//     } catch (e) {}
//   }
//
//   _start() async {
//     try {
//       await _recorder!.start();
//       var recording = await _recorder!.current(channel: 0);
//       setState(() {
//         _current = recording;
//       });
//
//       const tick = const Duration(milliseconds: 50);
//       new Timer.periodic(tick, (Timer t) async {
//         if (_currentStatus == RecordingStatus.Stopped) {
//           t.cancel();
//         }
//
//         var current = await _recorder!.current(channel: 0);
//         // print(current.status);
//         setState(() {
//           _current = current;
//           _currentStatus = _current!.status!;
//         });
//       });
//     } catch (e) {}
//   }
//
//   _stop() async {
//     var result = await _recorder!.stop();
//     File file = widget.localFileSystem.file(result!.path);
//     setState(() {
//       _current = result;
//       _currentStatus = _current!.status!;
//       duration = result.duration!;
//     });
//   }
//
//   void initAudioPlayer() {
//     audioPlayer.onDurationChanged.listen((Duration d) async {
//       setState(() {
//         duration = d;
//       });
//     });
//     audioPlayer.onAudioPositionChanged.listen((Duration p) {
//       setState(() => position = p);
//     });
//     audioPlayer.onPlayerCompletion.listen((event) {
//       onComplete();
//       setState(() {
//         position = new Duration();
//       });
//     });
//     audioPlayer.onPlayerError.listen((msg) {
//       setState(() {
//         //Older_audio_layer
//         // playerState = AudioPlayerState.STOPPED;
//
//         playerState = PlayerState.STOPPED;
//         duration = Duration(seconds: 0);
//         position = Duration(seconds: 0);
//       });
//     });
//   }
//
//   Future play() async {
//     await audioPlayer.play(_current!.path!);
//     setState(() {
//       //older_audio_player
//       // playerState = AudioPlayerState.PLAYING;
//
//       playerState = PlayerState.PLAYING;
//     });
//   }
//
//   Future pause() async {
//     await audioPlayer.pause();
//     setState(() => playerState = PlayerState.PAUSED);
//   }
//
//   void onComplete() {
//     setState(() => playerState = PlayerState.STOPPED);
//   }
// }
//
// class SliderPlayer extends StatefulWidget {
//   @override
//   _SliderPlayerState createState() => _SliderPlayerState();
// }
//
// class _SliderPlayerState extends State<SliderPlayer> {
//   int audioFilePosition = -1;
//   AudioPlayer audioPlayer = AudioPlayer();
//   Duration duration = new Duration();
//   Duration position = new Duration();
//
//   PlayerState playerState = PlayerState.STOPPED;
//
//   get isPlaying => playerState == PlayerState.PLAYING;
//
//   get isPaused => playerState == PlayerState.PAUSED;
//
//   @override
//   void initState() {
//     initAudioPlayer();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 8.h,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10), color: backArrawColor),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 4.w),
//               child: InkWell(
//                 onTap: () {
//                   isPlaying ? pause() : play();
//                 },
//                 child: CircleAvatar(
//                   backgroundColor: endGradientColor,
//                   child: Icon(
//                     isPlaying ? Icons.pause : Icons.play_arrow,
//                     color: White,
//                   ),
//                 ),
//               ),
//             ),
//             SliderTheme(
//               data: SliderThemeData(
//                   trackHeight: 1,
//                   thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5)),
//               child: Slider(
//                   value: position.inMilliseconds.toDouble(),
//                   onChanged: (double value) {
//                     seekToMilliSecond(value.toInt());
//                   },
//                   activeColor: endGradientColor,
//                   inactiveColor: profileTextFieldBorderColor,
//                   min: 0.0,
//                   max: position.inMilliseconds.toDouble() >
//                           duration.inMilliseconds.toDouble()
//                       ? position.inMilliseconds.toDouble()
//                       : duration.inMilliseconds.toDouble()),
//             ),
//             Padding(
//               padding: EdgeInsets.only(right: 4.w),
//               child: StringHelper.getNotoSansText(
//                   "${duration.inMinutes.toString()}:${duration.inSeconds.toString()}",
//                   color: Black,
//                   fontSize: 15,
//                   font: FontWeight.w500),
//             )
//           ],
//         ));
//   }
//
//   void seekToMilliSecond(int millisecond) {
//     Duration newDuration = Duration(milliseconds: millisecond);
//     audioPlayer.seek(newDuration);
//   }
//
//   void initAudioPlayer() async {
//     var path = await StringHelper().getRecordedAudioPath();
//     audioPlayer.setUrl(path!);
//     audioPlayer.onDurationChanged.listen((Duration d) async {
//       setState(() {
//         duration = d;
//       });
//     });
//     audioPlayer.onAudioPositionChanged.listen((Duration p) {
//       setState(() => position = p);
//     });
//     audioPlayer.onPlayerCompletion.listen((event) {
//       onComplete();
//       setState(() {
//         position = new Duration();
//       });
//     });
//     audioPlayer.onPlayerError.listen((msg) {
//       setState(() {
//         playerState = PlayerState.STOPPED;
//         duration = Duration(seconds: 0);
//         position = Duration(seconds: 0);
//       });
//     });
//   }
//
//   Future play() async {
//     var path = await StringHelper().getRecordedAudioPath();
//     await audioPlayer.play(path!);
//     setState(() {
//       playerState = PlayerState.PLAYING;
//     });
//   }
//
//   Future pause() async {
//     await audioPlayer.pause();
//     setState(() => playerState = PlayerState.PAUSED);
//   }
//
//   void onComplete() {
//     setState(() => playerState = PlayerState.STOPPED);
//   }
// }

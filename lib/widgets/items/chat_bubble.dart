// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_chat_bubble/chat_bubble.dart';
// import 'package:flutter_parsed_text/flutter_parsed_text.dart';
// import 'package:gadha/comman/functions.dart';
// import 'package:gadha/comman/services/auth_service.dart';
// import 'package:gadha/modules/shared/chat/models/message.dart';
// import 'package:url_launcher/url_launcher.dart' as url_launcher;

// import 'package:get/get.dart';
// import 'package:gadha/comman/config/colors.dart';

// export 'package:flutter_chat_bubble/chat_bubble.dart';

// String _getDate(Timestamp timeStamp) {
//   final date = timeStamp.toDate();
//   final time = '${date.hour} : ${date.minute}';
//   final now = DateTime.now();
//   final createdAt = date;
//   final isTody = now.day == createdAt.day &&
//       now.month == createdAt.month &&
//       now.year == createdAt.year;
//   if (isTody) {
//     return time;
//   } else {
//     final day =
//         '${createdAt.year} - ${createdAt.month} - ${createdAt.day}';
//     return day + time;
//   }
// }

// class GadhaChatBubble extends StatelessWidget {
//   final ChatMessageEntity msg;

//   const GadhaChatBubble(this.msg, {Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final sender = msg.sender == AuthService.currentUser!.id;
//     return ChatBubble(
//       clipper: ChatBubbleClipper6(
//         type: sender
//             ? BubbleType.sendBubble
//             : BubbleType.receiverBubble,
//         radius: 20,
//       ),
//       alignment:
//           sender ? Alignment.centerRight : Alignment.centerLeft,
//       margin: const EdgeInsets.only(top: 10),
//       elevation: 4,
//       padding: const EdgeInsets.only(top: 15, left: 20, right: 30),
//       gradient: !sender
//           ? AppColors.famousGradient(
//               begin: Alignment.bottomCenter, end: Alignment.topCenter)
//           : AppColors.chatBubbleGradient(),
//       child: InkWell(
//         onLongPress: () async {
//           await Clipboard.setData(ClipboardData(text: msg.content));
//           Q.alertWithSuccess('copyed_to_clipboard'.tr);
//         },
//         child: Container(
//           constraints: BoxConstraints(maxWidth: size.width * 0.6),
//           child: Column(
//             crossAxisAlignment: sender
//                 ? CrossAxisAlignment.start
//                 : CrossAxisAlignment.end,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               _buildParsedText(context),
//               const SizedBox(height: 5),
//               Row(
//                 children: <Widget>[
//                   if (sender) const Spacer(),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 10),
//                     child: Text(
//                       _getDate(msg.createdAt),
//                       textDirection: TextDirection.ltr,
//                       style: const TextStyle(
//                         fontSize: 9,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   if (!sender) const Spacer(),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildParsedText(BuildContext context) {
//     return ParsedText(
//       alignment: TextAlign.end,
//       text: msg.content.trim(),
//       textDirection: directionReversed,
//       parse: <MatchText>[
//         MatchText(
//           type: ParsedType.EMAIL,
//           style: const TextStyle(
//               color: Colors.white,
//               decoration: TextDecoration.underline),
//           onTap: (email) => url_launcher.launch('mailto:$email'),
//         ),
//         MatchText(
//           type: ParsedType.URL,
//           style: const TextStyle(
//               color: Colors.white,
//               decoration: TextDecoration.underline),
//           onTap: (url) async {
//             final _canLaunch =
//                 await url_launcher.canLaunch(url.toString());

//             if (_canLaunch) {
//               await url_launcher.launch(url.toString(),
//                   statusBarBrightness: Brightness.dark);
//             }
//           },
//         ),
//         MatchText(
//           type: ParsedType.PHONE,
//           style: const TextStyle(
//               color: Colors.white,
//               decoration: TextDecoration.underline),
//           onTap: (phoneNumber) async {
//             final _canLaunch =
//                 await url_launcher.canLaunch('tel://$phoneNumber');

//             if (_canLaunch) {
//               await url_launcher.launch('tel://$phoneNumber');
//             }
//           },
//         ),
//       ],
//       style: const TextStyle(color: Colors.white),
//     );
//   }
// }

// class ImageChatBubble extends StatelessWidget {
//   final ChatMessageEntity msg;

//   const ImageChatBubble(this.msg, {Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final sender = msg.sender == AuthService.currentUser!.id;
//     final type =
//         sender ? BubbleType.sendBubble : BubbleType.receiverBubble;
//     return InkWell(
//       onTap: () {},
//       child: ChatBubble(
//         clipper: ChatBubbleClipper6(
//           type: sender
//               ? BubbleType.sendBubble
//               : BubbleType.receiverBubble,
//           radius: 20,
//         ),
//         alignment:
//             !sender ? Alignment.centerLeft : Alignment.centerRight,
//         margin: const EdgeInsets.only(top: 10),
//         elevation: 4,
//         padding: EdgeInsets.zero,
//         gradient: sender
//             ? AppColors.chatBubbleGradient()
//             : AppColors.famousGradient(
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter),
//         child: Stack(
//           children: [
//             FancyShimmerImage(
//               imageUrl: msg.content,
//               boxFit: BoxFit.contain,
//               height: size.height * 0.2,
//               shimmerBaseColor: Colors.grey[300],
//               shimmerHighlightColor: Colors.grey[100],
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               height: 100,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: ShaderMask(
//                   shaderCallback: (rect) {
//                     return LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       stops: const [0.5, 1],
//                       colors: [
//                         Colors.transparent,
//                         Colors.black.withOpacity(1),
//                       ],
//                     ).createShader(
//                       Rect.fromLTRB(0, -150, rect.width, 0),
//                     );
//                   },
//                   blendMode: BlendMode.srcIn,
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Colors.transparent,
//                           Colors.black,
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 15,
//               left: type == BubbleType.receiverBubble ? 20 : null,
//               right: type != BubbleType.receiverBubble ? 20 : null,
//               child: Text(
//                 _getDate(msg.createdAt),
//                 textDirection: TextDirection.ltr,
//                 style: const TextStyle(
//                   fontSize: 9,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class AudioPlayerBubble extends StatefulWidget {
// //   final String? audioUrl;
// //   final BubbleType type;
// //   final String? sentTime;
// //   // final AudioController? audioController;

// //   const AudioPlayerBubble({
// //     Key? key,
// //     this.audioUrl,
// //     this.type = BubbleType.sendBubble,
// //     this.sentTime,
// //     // this.audioController,
// //   }) : super(key: key);

// //   @override
// //   _AudioPlayerBubbleState createState() => _AudioPlayerBubbleState();
// // }

// // class _AudioPlayerBubbleState extends State<AudioPlayerBubble> {
// //   bool _isLoading = false;
// //   AssetsAudioPlayer? _assetsAudioPlayer;

// //   Future<void> _initiatOpenAudio() async {
// //     _assetsAudioPlayer ??= AssetsAudioPlayer.withId(widget.audioUrl);
// //     return _assetsAudioPlayer!.open(Audio.network(widget.audioUrl!));
// //   }

// //   @override
// //   void dispose() {
// //     if (_assetsAudioPlayer != null) {
// //       final _id = _assetsAudioPlayer!.id;
// //       _assetsAudioPlayer!.dispose();
// //       log('`_assetsAudioPlayer(${_id.split('-').last})` was disposed');
// //     }

// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final Size size = MediaQuery.of(context).size;
// //     return ChatBubble(
// //       clipper: ChatBubbleClipper6(type: widget.type, radius: 20),
// //       alignment: widget.type == BubbleType.sendBubble ? Alignment.centerRight : Alignment.centerLeft,
// //       margin: const EdgeInsets.only(top: 10),
// //       elevation: 4,
// //       padding: EdgeInsets.zero,
// //       gradient: widget.type == BubbleType.sendBubble
// //           ? AppColors.famousGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter)
// //           : AppColors.chatBubbleGradient(),
// //       child: ConstrainedBox(
// //         constraints: BoxConstraints(maxWidth: size.width * 0.7),
// //         child: Stack(
// //           children: [
// //             // StreamBuilder<RealtimePlayingInfos>(
// //             //   stream: _assetsAudioPlayer?.realtimePlayingInfos,
// //             //   builder: (BuildContext context, AsyncSnapshot<RealtimePlayingInfos> snapshot) {
// //             //     final realtimePlayingInfos = snapshot.data;
// //             //     final _isPlaying = realtimePlayingInfos?.isPlaying ?? false;
// //             //     final _maxDuration = realtimePlayingInfos?.duration ?? Duration.zero;
// //             //     final _currentDuation = realtimePlayingInfos?.currentPosition ?? Duration.zero;
// //             //     return MediaPlayerSlider(
// //             //       notLoaded: realtimePlayingInfos == null,
// //             //       isLoadingAudio: _isLoading,
// //             //       isPlaying: _isPlaying,
// //             //       duration: _maxDuration,
// //             //       currentPosition: _currentDuation,
// //             //       onToggle: () async {
// //             //         if (realtimePlayingInfos == null) {
// //             //           setState(() => _isLoading = true);
// //             //           try {
// //             //             await _initiatOpenAudio();
// //             //           } catch (e) {
// //             //             log('Error in the player $e');
// //             //           } finally {
// //             //             setState(() => _isLoading = false);
// //             //           }
// //             //           return;
// //             //         }
// //             //         await _assetsAudioPlayer?.playOrPause();
// //             //       },
// //             //       seekTo: (duration) {
// //             //         _assetsAudioPlayer?.seek(duration!);
// //             //       },
// //             //     );
// //             //   },
// //             // ),
// //             Positioned(
// //               bottom: 13,
// //               left: widget.type == BubbleType.sendBubble ? 20 : null,
// //               right: widget.type != BubbleType.sendBubble ? 20 : null,
// //               child: Text(
// //                 widget.sentTime!,
// //                 textDirection: TextDirection.ltr,
// //                 style: const TextStyle(
// //                   fontSize: 9,
// //                   color: Colors.white,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

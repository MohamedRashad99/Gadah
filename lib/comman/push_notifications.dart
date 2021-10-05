import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  PushNotificationService._();
  static final PushNotificationService _instance = PushNotificationService._();
  static PushNotificationService get instance => _instance;

  Future<String?> getToken() => _fcm.getToken();

  Future<void> initialise() async {
    try {
      final settings = await _fcm.requestPermission();
      log('User granted permission: ${settings.authorizationStatus}');
    } catch (e) {
      log(e.toString());
    }

    final _token = await _fcm.getToken();

    print(('Device Token: [$_token]'));



    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Vibration.hasVibrator().then((value) {
    //   if (value) Vibration.vibrate();
    // });
    //   return Get.snackbar<void>(
    //     'null',
    //     'null',
    //     padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
    //     messageText: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         const Text('Title', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500)),
    //         const SizedBox(height: 8),
    //         const Text('Message'),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Center(
    //             child: Card(
    //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    //               color: Colors.black12,
    //               child: const SizedBox(width: 40, height: 5),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //     colorText: Colors.transparent,
    //     backgroundColor: Colors.white,
    //     barBlur: 30,
    //     snackStyle: SnackStyle.GROUNDED,
    //     overlayColor: Colors.white,
    //     boxShadows: [
    //       BoxShadow(
    //         offset: const Offset(0, 15),
    //         color: Colors.black.withOpacity(0.08),
    //         blurRadius: 15,
    //       ),
    //     ],
    //     margin: EdgeInsets.zero,
    //   );
    // });
  }
}

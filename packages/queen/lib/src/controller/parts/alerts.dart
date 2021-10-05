part of 'package:queen/src/controller/controller.dart';

mixin QAlerts on _QueenControllerImp {
  void alertWithSuccess(Object msg, {String desc = ''}) {
    edgeAlert(
      context,
      title: msg.toString(),
      icon: FontAwesomeIcons.check,
      backgroundColor: const Color(0xFF4A189B),
      description: desc,
    );
  }

  void alertWithErr(Object msg, {String desc = ''}) {
    edgeAlert(
      context,
      title: msg.toString(),
      icon: FontAwesomeIcons.times,
      backgroundColor: const Color(0xFFDC3130),
      description: desc,
    );
  }
}

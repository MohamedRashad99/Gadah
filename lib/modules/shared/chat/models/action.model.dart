import 'package:flutter/cupertino.dart';

class ActionModel {
  final String title;
  final VoidCallback onPress;
  final IconData icon;

  ActionModel({
    required this.title,
    required this.onPress,
    required this.icon,
  });
}

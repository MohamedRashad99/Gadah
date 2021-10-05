import 'package:flutter/foundation.dart';
import 'package:queen/queen.dart';

class BotMessageAction extends Equatable {
  final String title;
  final VoidCallback action;
  const BotMessageAction({
    required this.title,
    required this.action,
  });

  BotMessageAction copyWith({
    String? title,
    VoidCallback? action,
  }) {
    return BotMessageAction(
      title: title ?? this.title,
      action: action ?? this.action,
    );
  }

  @override
  List<Object> get props => [title, action];
}

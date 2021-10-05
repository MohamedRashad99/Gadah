import 'package:equatable/equatable.dart';
import 'message_action.dart';

class BotMessage extends Equatable {
  final String msg;
  final List<BotMessageAction> actions;
  final bool isFromBot;
  const BotMessage({
    required this.msg,
    this.actions = const [],
    required this.isFromBot,
  });

  BotMessage copyWith({
    String? msg,
    bool? isFromBot,
    List<BotMessageAction>? actions,
  }) {
    return BotMessage(
      msg: msg ?? this.msg,
      actions: actions ?? this.actions,
      isFromBot: isFromBot ?? this.isFromBot,
    );
  }

  factory BotMessage.fromBot({
    required String msg,
    List<BotMessageAction> actions = const [],
  }) {
    return BotMessage(
      msg: msg,
      actions: actions,
      isFromBot: true,
    );
  }
  factory BotMessage.fromUser({
    required String msg,
  }) {
    return BotMessage(
      msg: msg,
      isFromBot: false,
    );
  }

  @override
  List<Object> get props => [msg, actions, isFromBot];
}

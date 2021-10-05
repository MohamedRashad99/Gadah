import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:gadha/modules/client/bot_chat/models/message_action.dart';
import 'package:gadha/modules/client/bot_chat/models/messsage.dart';

import 'package:queen/queen.dart';
import 'package:gadha/comman/config/colors.dart';

export 'package:flutter_chat_bubble/chat_bubble.dart';

class BotChatBubble extends StatelessWidget {
  final BotMessage msg;

  const BotChatBubble(this.msg, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper6(
          type:
              msg.isFromBot ? BubbleType.sendBubble : BubbleType.receiverBubble,
          radius: 20),
      alignment: msg.isFromBot ? Alignment.centerRight : Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 10),
      elevation: 4,
      padding: const EdgeInsets.only(top: 15, left: 20, right: 30),
      gradient: !msg.isFromBot
          ? AppColors.famousGradient(
              begin: Alignment.bottomCenter, end: Alignment.topCenter)
          : AppColors.chatBubbleGradient(),
      child: Container(
        constraints: BoxConstraints(maxWidth: size.width * 0.6),
        child: Column(
          crossAxisAlignment:
              msg.isFromBot ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildParsedText(context),
            const SizedBox(height: 15),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: msg.actions.length,
              itemBuilder: (_, i) => _buildAction(msg.actions[i]),
              separatorBuilder: (_, i) => const Divider(color: Colors.white),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Widget _buildParsedText(BuildContext context) {
    final txt = Text(
      msg.msg,
      // style: const TextStyle(color: Colors.white),
      style: textTheme.headline6!.apply(color: Colors.white),
    );
    return msg.isFromBot ? txt : Center(child: txt);
  }

  Widget _buildAction(BotMessageAction e) {
    return InkWell(
      onTap: e.action,
      child: Center(
          child: Text(
        e.title,
        style: const TextStyle(color: Colors.white),
      )),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gadha/comman/services/auth_service.dart';
import 'package:gadha/modules/client/bot_chat/models/message_action.dart';
import 'package:gadha/modules/client/bot_chat/models/messsage.dart';
import 'package:gadha/modules/client/quick_order/page.dart';
import 'package:gadha/modules/client/search/page.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

part 'actions_state.dart';

class ActionsCubit extends Cubit<ActionsState> {
  ActionsCubit() : super(ActionsLoading()) {
    loadInitalMessages();
  }
  final _messages = <BotMessage>[];

  void loadInitalMessages() {
    _messages.addAll([
      // user name wellcome

      BotMessage.fromBot(
          msg: '${'welcome'.tr}  ${AuthService.currentUser?.name ?? ''}'),
      BotMessage.fromBot(msg: 'greeatings_chat_message'.tr),
      BotMessage.fromBot(msg: 'how_can_i_serve_you'.tr, actions: [
        // BotMessageAction(
        //   title: 'show_me_my_orders'.tr,
        //   action: () {
        //     actionPicked('show_me_my_orders');
        //     Q.replace()
        //   },
        // ),
        BotMessageAction(
          title: 'new_order'.tr,
          action: () {
            actionPicked('new_order');
            Q.to(SearchPage());
          },
        ),
        BotMessageAction(
          title: 'quick_order'.tr,
          action: () {
            actionPicked('quick_order'.tr);
            Q.to(const CustomService());
          },
        ),
      ]),
    ]);
    refresh();
  }

  void actionPicked(String name) {
    _messages.add(BotMessage.fromUser(msg: name.tr));
    refresh();
  }

  void refresh() => emit(MessagesLoaded(_messages));
}
